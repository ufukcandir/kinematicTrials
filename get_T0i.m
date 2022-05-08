function [T0_i, Tj_i] = get_T0i(theta, a, d, alpha)

n = length(a); % Number of joints

T0_i = cell(1,n);
T0_j = cell(1,n);
Tj_i = cell(1,n);
T0_j{1} = eye(4); % Define as empty at first
for i = 1:n
    % Find single trans. matrix
    Tj_i{i} = forwardTransfer(a(i), alpha(i), d(i), theta(i));
    % Multiply that matrix with the multiplication of all previous ones
    T0_i{i} = T0_j{i}*Tj_i{i};
    % Save result to use in next loop
    T0_j{i+1} = T0_i{i};
end

assignin('base','Tj_i',Tj_i);
assignin('base','T0_j',T0_j);

end