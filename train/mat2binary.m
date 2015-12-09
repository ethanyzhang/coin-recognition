files = {'quarter.mat', 'quarter_eagle.mat', 'dime.mat', 'dime_op.mat', 'nickel_head.mat', 'nickel_head_2.mat', 'nickel_house.mat'};
for file = files
    [pathstr,name,ext] = fileparts(file{1});
    fid = fopen([name '.bin'], 'wb');
    load(file{1});
    fwrite(fid, result');
    fclose(fid);
end