files = dir('*Eq*.jpg');
result = [];
for file = files'
    disp(file.name);
    img = imread(file.name);
    inv = rotate_inv(img);
    result = [result reshape(inv, 32040, 1)];
end
    