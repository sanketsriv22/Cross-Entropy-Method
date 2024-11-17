function y = fcn_ackley(x)
  % Ackely's function from Appendix B of Algorithms for
  % Optimiztion.
  % Input:
  % x -- vector of input locations (design variables).
  % x must be a column vector.
  % Output:
  % y -- objective function.  This obj fcn has many local
  % minima.
    
  global a
  global b
  global c
  a = 20;
  b = 0.2;
  c = 2*pi;
  
  % Dimension we are working in.
  d = length(x);
  
  % Terms to sum up.
  t1 = -a*exp(-b*sqrt(x'*x/d));
  t2 = -exp(sum(cos(c*x))/d);
  t3 = a;
  t4 = exp(1);
  
  % Output
  y = t1+t2+t3+t4;
  
end
