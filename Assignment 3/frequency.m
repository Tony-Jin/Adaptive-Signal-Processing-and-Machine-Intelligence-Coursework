function f = frequency(n)
    
if n <= 500
    f = 100; 
elseif n <= 1000
    f = 100 + (n - 500) / 2;
elseif n <= 1500
    f = 100 + ((n - 1000) / 25)^2;
else
    f = 0;
end

end