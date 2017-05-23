clear all;

% Choose Case 2 or 3
c = 3;

% Construct function
a = sym('a');
mu = sym('mu');
var(1) = sym('R_a');
var(2) = sym('R_b');
var(3) = sym('S_aa');
var(4) = sym('S_ab');
var(5) = sym('S_bb');
q_aa = var(1)*(var(1) - 1)/((a + var(1))*(a + var(1) - 1));
q_ab = var(1)*var(2)/((a + var(1))*(a + var(2)));
q_bb = var(2)*(var(2) - 1)/((a + var(2))*(a + var(2) - 1));
F(1) = mu - 2*var(3)*q_aa + 2*var(5)*q_bb;
F(2) = var(3)*q_aa - var(4)*q_ab - var(5)*q_bb;
F(3) = var(3)*(2*q_aa - 1);
F(4) = var(4)*(2*q_ab - 1);
F(5) = var(5)*(2*q_bb - 1);

% Derivatives
for i = 1:5
    for j = 1:5
        jac(i, j) = diff(F(i), var(j));
    end
end

% Choose Case 2 or Case 3
if (c == 2)
    a = 5;
    mu = 500;
    R_a = 0.5*(sqrt(8*a^2 + 1) + 2*a + 1);
    R_b = 0.5*(sqrt(8*a^2 + 1) + 2*a + 1);
    S_aa = 2*mu;
    S_ab = 0;
    S_bb = mu;
elseif (c == 3)
    a = 5;
    mu = 500;
    R_a = 0.5*(sqrt(8*a^2 + 1) + 2*a + 1);
    R_b = 0.5*(sqrt(8*a^2 + 1) + 2*a - 1);
    S_aa = mu;
    S_ab = mu;
    S_bb = 0;
end

% Print Jacobian and eigenvalues
jac = double(subs(jac))
eig_jac = eig(jac)