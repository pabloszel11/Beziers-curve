require 'nyaplot'

def factorial(n)
	if n == 1 || n == 0
		n
	else
		n * factorial(n-1)
	end
end

def newton(n,k)
	res = 1
	i = 1
	while i <= k
		res = res * (n - i + 1) / i
		i = i + 1
	end  
	return res
end

def bernstein(u,n,i)
	x1 = u ** i
	x2 = (1-u) ** (n-i)
	return newton(n,i) * x1 * x2
end

def bezier(wx, wy, v, n)
	t = 0
	i = 0
	sumx = Array.new
	sumy = Array.new
	while t <= 1
		sum1 = 0
		while i < n
			sum1 = sum1 + (wx[i] * v[i] * bernstein(t,n,i))
			i = i + 1
		end
		i = 0
		sum2 = 0
		while i < n
			sum2 = sum2 + (wy[i] * v[i] * bernstein(t,n,i))
			i = i + 1 
		end
		i = 0
		den = 0
		while i < n
			den = den + (v[i] * bernstein(t,n,i))
			i = i + 1
		end
		i = 0
		s1 = sum1/den
		s2 = sum2/den

		sumx << s1
		sumy << s2
		t = t + 0.001
	end
	sumx.shift
	sumy.shift

	plot = Nyaplot::Plot.new
	sc = plot.add(:scatter, sumx, sumy)
	plot.export_html
end

x = [0,3.5,25,25,-5,-5,15,-0.5,19.5,7,1.5]
y = [0,36,25,1.5,3,33,11,35,15.5,0,10.5]
v = [1,6,4,2,3,4,2,1,5,4,1]

bezier(x,y,v1,11)