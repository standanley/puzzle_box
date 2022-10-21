# I'm here becuase I wanted to use rotate_extrude with a polygon not at z=0
import math
import numpy as np
import scipy.spatial


polygon = [
            [5,0],
            [10,0],
            [10,20],
            [5, 20],
            ]
polygon = [
            [0,0],
            [1,0],
            [1,1],
            [2,1],
            [2,0],
            [3,0],
            [3,1],
            [4,1],
            [4,0],
            [5,0],
            [5,-1],
            [0,-1]
]
polygon = [
    [1, 0],
    [0.95, 0.05],


    [0.95, 0.15],
    [0.9, 0.15],
    [0.9, 0.1],

    [0.8, 0.1],
    [0.8, 0.15],
    [0.85, 0.15],
    [0.85, 0.25],
    [0.8, 0.25],
    [0.8, 0.2],

    [0.7, 0.2],
    [0.7, 0.25],
    [0.75, 0.25],
    [0.75, 0.35],
    [0.7, 0.35],
    [0.7, 0.3],


    [0.6, 0.4],
    #[2, 2.8],
    [2, 0.4],
    [2, -1],

    #[0.6, 0.4],
    ##[0, -0.02],
    #[0.5, 0],#-0.48],
    #[1.01, -0.01],
]

x = 0.9
a = (x-.5)/3
b = 2*a
d = 0.01
h = 0.05

center_dist = (1+0.8)/3
polygon = [
    [0.9, 0],

    #[0.5+a+d/2, b-d/2],
    #[0.5+a+h+d/2, b+2*h-d/2],
    #[0.5+a+h-d/2, b+2*h+d/2],
    #[0.5+a-d/2, b+d/2],

    # hook
    [0.65, 0.25],#[0.65, 0.3],
    [0.6, 0.2],
    [0.65, 0.15],
    [0.6, 0.1],

    #[0.575, 0.225],

    [0.55, 0.35],

    #[0.47, 0.43],
    [0.45, 0.45], # this is the first one that seems bad; not surprising in retrospect
    [center_dist, center_dist],
    #[.43, .47],
    #[.41, .49],
    #[.39, .51],
    #[.37, .53],
    #[.35, .55],

    #[.46, .6],

    [1.2, 0.8],
    [2, -1],
]

polygon = np.array(polygon).reshape((len(polygon), 2))
polygon = np.concatenate((polygon, np.ones((len(polygon), 1))), axis=1)
polygon[7,2] = center_dist
#offset = np.array([-0.1, 0, 0])
#polygon += offset

polygon_D = [
    [0.8, 0.0, 1],
    [0.85, 0.1, 1],
    [0.7, 0.15, 1],
    [0.76, 0.05, 1],
    [0.6, 0.1, 1],

    [0.5, 0.3, 1],

    [0.35, 0.45, 1],
    [center_dist, center_dist, center_dist],
    [3.1, 3, 3],
    [1.1, -0.2, 1]

]

polygon_E = [
    [0.8, 0.0, 1],
    [0.85, 0.2, 1],
    [0.7, 0.15, 1],
    [0.72, 0.05, 1],
    [0.58, 0.18, 1],
    [0.6, 0.3, 1],


    [0.5, 0.3, 1],

    [0.35, 0.45, 1],
    [center_dist, center_dist, center_dist],
    [3.1, 3, 3],
    [1.1, -0.2, 1]

]

polygon_F = [
    [0.8, 0.0, 1],
    [0.7, 0.1, 1],
    [0.83, 0.2, 1],
    [0.71, 0.35, 1],
    [0.69, 0.25, 1],
    [0.63, 0.33, 1],


    [0.5, 0.3, 1],

    [0.35, 0.45, 1],
    [center_dist, center_dist, center_dist],
    [3.1, 3, 3],
    [1.1, -0.2, 1]

]






name = 'my_extrusion_E'
polygon = np.array(polygon_E)

extrude_point = [0,0,0]
extrude_axis = np.array([-1,-1,-1])
start_angle = -0.99*math.pi
end_angle = math.pi
extrude_point = np.array(extrude_point)
extrude_axis_norm = np.array(extrude_axis) / math.sqrt(sum(x**2 for x in extrude_axis))
#points = list(polygon)
points = []
FRAMES= 20
reverse_endcaps = True
reverse_triangles = True
deskew = False








if deskew:
    # add in-between points
    print('befor')
    print(polygon)
    MULITPLIER = 5
    polygon_new = []
    for i in range(len(polygon)):
        a = polygon[i]
        b = polygon[(i+1)%len(polygon)]
    for j in range(MULITPLIER):
        polygon_new.append(a + (b-a)*j/MULITPLIER)
    polygon = np.array(polygon_new)
    print('after')
    print(polygon)
    print()

    def dot(a, b):
        return sum(aa*bb for aa,bb in zip(a, b))

    def proj(b, a):
        # project a onto b
        return b/dot(b, b) * dot(a, b)

    def move_to_plane(a_vec):
        #a_vec = a - extrude_point
        parallel = proj(extrude_axis, a_vec)
        perp = a_vec - parallel
        return perp
    
    def angle(a, b):
        try:
            angle_abs = math.acos(dot(a, b) / (dot(a, a) * dot(b, b))**.5)
            is_pos = np.dot(np.cross(a, b), extrude_axis) > 0
            sign = 1 if is_pos else -1
            return sign*angle_abs
        except ValueError:
            return float('nan')
    
    goal = move_to_plane(polygon[0]-extrude_point)

    polygon_deskewed = []
    for p in polygon:
        p_shifted = p-extrude_point
        theta = angle(move_to_plane(p_shifted), goal)
        rotvec = extrude_axis_norm * theta
        rotation_about_origin = scipy.spatial.transform.Rotation.from_rotvec(rotvec)
        new_p_shifted = rotation_about_origin.apply(p_shifted)
        new_p = new_p_shifted + extrude_point
        #new_p = move_to_plane(p_shifted) + extrude_point
        if np.isnan(new_p[0]):
            new_p = p
        polygon_deskewed.append(new_p)
        diff = new_p - polygon_deskewed[-2] if len(polygon_deskewed) >=2 else None
        print(p, theta, new_p, diff)
    polygon = polygon_deskewed









# TODO triangulate original polygon
N = len(polygon)
triangles = [range(N), range(N*FRAMES-1, N*(FRAMES-1)-1, -1)]
if reverse_endcaps:
    triangles = [t[::-1] for t in triangles]
#triangles = []


for i in range(FRAMES):
    theta = start_angle + i*(end_angle - start_angle)/(FRAMES-1)
    rotvec = extrude_axis_norm * theta
    rotation_about_origin = scipy.spatial.transform.Rotation.from_rotvec(rotvec)
    def rotate(xyz):
        #xyz = np.concatenate((xy, [0]))
        xyz_shifted = xyz - extrude_point
        ans_shifted = rotation_about_origin.apply(xyz_shifted)
        ans = ans_shifted + extrude_point
        return ans
    
    new_points = [rotate(p) for p in polygon]
    points += new_points

    if i != 0:
        # now we need to do the triangles
        j0 = (i-1)*N
        j1 = i*N
        for k0 in range(N):
            k1 = (k0+1)%N
            #triangles.append([j0+k0, j1+k0, j1+k1])
            #triangles.append([j0+k0, j1+k1, j0+k1])
            if reverse_triangles:
                triangles.append([j0+k0, j0+k1, j1+k0])
                triangles.append([j1+k0, j0+k1, j1+k1])
            else:
                triangles.append([j0+k0, j1+k0, j0+k1])
                triangles.append([j1+k0, j1+k1, j0+k1])


#print(points)
#print(triangles)
text = ''
text += f'module {name} () {{'
text += f'polyhedron(points=['
for p in points:
    text += f'{list(p)},\n'
text += '], faces=[\n'
for t in triangles:
    text += f'{list(t)},\n'
text += '], convexity=10);\n'

text += '}'

f = open(f'C:\\Users\\Daniel\\Documents\\code\\3d_modeling\\{name}.scad', 'w')
f.write(text)
f.close()
