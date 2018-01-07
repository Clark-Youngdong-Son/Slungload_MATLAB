function result = Rotate_syd(phi,theta,psi,target)
%Rotation matrix from 'body' to 'inertia' frame
rotX = [1       0          0;
    0 cos(phi) -sin(phi);
    0 sin(phi)  cos(phi)];
rotY = [cos(theta)   0 sin(theta);
    0            1          0;
    -sin(theta)  0 cos(theta)];
rotZ = [cos(psi) -sin(psi) 0;
    sin(psi)  cos(psi) 0;
    0         0 1];
result = rotZ*rotY*rotX*target;