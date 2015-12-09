%files = dir('dime_*.mat');
files = {'quarter.mat'; 'quarter_eagle.mat'; 'dime.mat'; 'dime_op.mat'; 'nickel_head.mat'; 'nickel_head_2.mat'; 'nickel_house.mat'};
fcnt = size(files);
fcnt = fcnt(1);
input = [];
findices = [];
for i=1:fcnt
    disp(files{i});
    load(files{i});
    input = [input, result];
    ccnt = size(result);
    ccnt = ccnt(2);
    subindices = ones(1, ccnt) * i - 1;
    findices = [findices, subindices];
    clear result;
end
target = de2bi(2.^findices);
target = target';
setdemorandstream(491218382)
net = patternnet(10);
view(net)
x = im2double(input);
[net,tr] = train(net,x,target);
nntraintool

% for i=1:4
%     inv=rotate_inv(strcat('validate\quarter_closely_3_', num2str(i), '.jpg'));
%     in=reshape(inv, 32040, 1);
%     testx = im2double(in);
%     testY = net(testx);
%     testY = uint8(testY);
%     testIndices = vec2ind(testY);
%     disp(strcat('validate\quarter_closely_3_', num2str(i), '.jpg'));
%     disp(files{testIndices});
% end


%load NewQuarterHead_1126
%input = result(:,1:30);
%load pennyHead
%input = [input,result];
%load NewQuarterHead_1126
%test = result(:,31:36);
%target = [zeros(1,30),ones(1,20)];
%target1 = imcomplement(target);
%target = [target;target1];

%testx = im2double(test);
%testY = net(testx);
%testIndices = vec2ind(testY)