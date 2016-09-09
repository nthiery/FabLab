# coding: utf-8
# The goal of this code is to generate suitable spacers (/croisillons/) to make a physical Penrose tiling in a bathroom.
# (We can't use the generic cross-shaped spacers...)
# Inspired by http://images.math.cnrs.fr/Un-parquet-de-Penrose.html where (wooden) tiles touch each other,
# but here we need a small space between tiles (we chose 3mm) and thus those spacers.

################################################################################
# params
scale = 100/35.27 # This scales 1 svg unit (pixel) to 1mm
grout_width = 3 * scale # 3mm (grout is /joint/)
spacer_length = grout_width * 4
paperwidth, paperheight = 297*scale, 420*scale   # A3. «paper» will actually be Plexiglas.

################################################################################
# imports
import math, random, sys
import cairo # the alternative library cairocffi seems not supported by rsvg.Handle.render_cairo()
import rsvg  # sudo apt-get install librsvg-dev python-rsvg
import xml.etree.ElementTree as ET

# We use shapely for high level geometry computations.
# Another Python geometry package, sympy, does symbolic computation and is said to get slow.
# To install: sudo apt-get install libgeos-dev
import shapely.geometry, shapely.affinity, shapely.prepared

################################################################################
# Build the shapes

# .buffer computes the points at distance at most grout_width/2, approximating quarter-circles with 3 points
branch = shapely.geometry.LineString([(0,0),(spacer_length,0)])\
    .buffer(grout_width/2, resolution=3)

def spacer(angles):
    """eg spacer([4,2,3])"""
    branches = shapely.geometry.Polygon(branch)
    angle = 0
    for angle_incr in angles:
        angle += angle_incr * 36 # π/5
        rotated_branch = shapely.affinity.rotate(branch, angle, origin=(0,0), use_radians=False)
        # origin can be ‘center’ (BOUNDING BOX center, default), ‘centroid’ (geometry’s centroid), Point, or (x0, y0).
        branches = branches.union(rotated_branch)
    return branches

# approximated from manual counting on decompte_sommets.xcf
# vertex are numbered according to http://images.math.cnrs.fr/IMG/jpg/vertex_atlas.jpg
proportions =        [27, 70, 17, 11, 44, 9, 12]
proportions_approx = [ 9, 24,  6,  4, 15, 3,  4]
spacers = (
    [spacer([4,4,2])]        *proportions[0]
  + [spacer([3,3,4])]        *proportions[1]
  + [spacer([4,2,2,2])]      *proportions[2]
  + [spacer([2,2,2,2,2])]    *proportions[3]
  + [spacer([1,2,1,3,3])]    *proportions[4]
  + [spacer([1,1,2,2,2,2])]  *proportions[5]
  + [spacer([1,1,2,1,1,2,2])]*proportions[6])

################################################################################
# Place the shapes on the sheet
def tetris_pack(geoms, width, stepx, stepy, nb_orientations):
    """Inside the sheet of paper of the given width, we "drop" the pieces [geoms] like in tetris:
    find the minimum y such that the piece does not intersect with the already fallen pieces.
    We try each column (there are width/stepx of them) and each orientation (there are nb_orientations of them),
      and chose the one letting the piece fall as low as possible.
    (Note that the y axis in shapely is downwards,
    so on the final drawing only, "falling" and "decreasing y" actually mean towards the top of the sheet.
    But our vocabulary (and intuition) seems more suited to describe falling pieces so we ignore this axis orientation, like Jupyter does.).
    geoms must have their branches meeting at (0,0)."""
    result = shapely.geometry.MultiPolygon()
    simplified_result = shapely.geometry.MultiPolygon()   # used to check if a falling piece intersects result
    simplified_result_prepared = shapely.prepared.prep(simplified_result)   # used to check if a falling piece intersects result
    nb_stepx = int(width/stepx)
    starting_yoffs = [0] * nb_stepx # "water level": a lower bound on the height of already fallen pieces, in each column
    nb_placed = 0                   # to report progress to the user
    for geom in geoms:              # place each piece one by one
        possible_positions = []
        for i in range(nb_orientations): # try all orientations
            geom_rotated = shapely.affinity.rotate(geom, 360/nb_orientations*i, origin=(0,0))
            minx,miny,maxx,maxy = geom_rotated.bounds
            for x in range(  int(math.ceil(-minx/stepx)),  int(math.floor((width-maxx)/stepx)) ): # try each column
                geom_xshifted = shapely.affinity.translate(geom_rotated, x*stepx, yoff=-miny)
                yoff=starting_yoffs[x] # no need to check lower than that
                geom_yshifted = geom_xshifted
                while simplified_result_prepared.intersects(geom_yshifted): # move the piece up until it fits
                    yoff += stepy
                    geom_yshifted = shapely.affinity.translate(geom_xshifted, xoff=0, yoff=yoff)
                possible_positions.append({'x':x, 'yoff':yoff, 'maxy':yoff+maxy-miny, 'geom':geom_yshifted})
        best_position = min(possible_positions, key = lambda d: d['maxy'])
        starting_yoffs[best_position['x']] = best_position['yoff']
        result = result.union(best_position['geom'])
        simplified_result = simplified_result.union(best_position['geom'])
        simplified_result_prepared = shapely.prepared.prep(simplified_result)  # this makes intersection tests more efficient
        minx,miny,maxx = best_position['geom'].bounds[0:3]
        simplified_result = simplified_result.union(
            shapely.geometry.Polygon([(minx,-1e-6), (minx,miny), (maxx,miny), (maxx,-1e-6)]))
        nb_placed+=1
        sys.stdout.write("\rPlaced:{}".format(nb_placed)); sys.stdout.flush()
    return result

print ("To place:{}".format(len(spacers)))
# for debugging:
# random.shuffle(spacers)
# packing = tetris_pack(spacers[0:20], paperwidth/3, 3*scale, 3*scale, 10)
packing = tetris_pack(spacers, paperwidth, 3*scale, 3*scale, 10)
print()

################################################################################
# Output the result with cairo
def fix_svg(svg):
    """Shapely.geometry.svg() allows to specify only stroke-width and fill color.
    Here we also specify mandatory params for the laser cutter: opacity and stroke color."""
    xml = ET.fromstring(svg)
    for x in xml.findall('path'):
        x.attrib['fill'] = '#ffffff'
        x.attrib['stroke-width'] = '1'
        x.attrib['opacity'] = '1'
        x.attrib['stroke'] = '#ff0000'
    return ET.tostring(xml)

def render_shapely_to_cairo(geom, context):
    minx, miny, maxx, maxy = geom.bounds
    svg = fix_svg(geom.svg())
    svg = '<svg viewBox="{} {} {} {}">'.format(minx,miny,maxx,maxy) + svg + '</svg>'
    svg = rsvg.Handle(data=svg)
    svg.render_cairo(context)

surface = cairo.PDFSurface("spacers.pdf", paperwidth, paperheight)
ctx = cairo.Context(surface)
render_shapely_to_cairo(packing, ctx)

ctx.show_page()
