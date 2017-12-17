dog = imread('outmessage.png');
%imshow(dog)
%dog = double(dog);
[n, m] = size(dog);

binStack = java.util.Stack();
bin_message = zeros(1, n * m);

%pull the binary string from the image
index = 0;
for i = 1:n
    for j = 1:m
        index = index + 1;
        bin_message(index) = mod(dog(i, j), 2);
    end
end

%mod(dog(1,1:31),2)
%bin_message(1, 1:31)
[a, b] = size(bin_message);
message_int = zeros(b/8, 1);
stop = 0;
for i = 1:b
%for i = 1:938
    % if we see the stop message, break
    if(bin_message(i) > 0) 
        stop = stop + 1;
        if(stop == 9)
            break
        end
    else
        stop = 0;
    end
    binStack.push(bin_message(i));
    if(binStack.size() == 7)
        char_int = 0;
        count = 0;
        while ~binStack.isEmpty()
            char_int = char_int + binStack.pop() * 2^count;
            count = count + 1;
        end
        message_int(i/7) = char_int;
    end
end
%{
[b, a] = size(message_int);
message = zeros(fix(i/7), 1);

for j = 1:size(message)
    message(j) = char(message_int(j));
end
%}
message = char(message_int(1:fix(i/7)))'
%message
%message = convertCharsToStrings(message)

message_str = '';
%size(message)
%for i = 1:size(message)
    
    %strcat(message_str, message(i));
%end

%message_str