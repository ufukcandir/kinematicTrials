function T0_i = get_T0i(a,alpha,d,theta,n)

T0_i = cell(1,n);
T0_j = cell(1,n);
Tj_i = cell(1,n);
T0_j{1} = eye(4);
for i = 1:n
    Tj_i{i} = forwardTransfer(a(i), alpha(i), d(i), theta(i));
    T0_i{i} = T0_j{i}*Tj_i{i};
    T0_j{i+1} = T0_i{i};
end

end