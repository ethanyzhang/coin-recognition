files = {'quarter.mat', 'quarter_eagle.mat', 'dime.mat', 'dime_op.mat', 'nickel_head.mat', 'nickel_head_2.mat', 'nickel_house.mat'};
for file = files
    [pathstr,name,ext] = fileparts(file{1});
    load([name '.mat']);
    csvwrite([name '.csv'], result');
end
