!			In our machines there is a powerful random number generator which appears to be
!			both fast and with good statistical properties. On most machines you just need
!			to compile your program with the option 
!			
!			-ldranxor
!			
!			In some other machines, however, you need to include the source code dranxor.f90 
!			in your compiler instruction. For instance
!			
!			ifort -fast test.f90 dranxor.f90 -o test.x
!			gfortran -O test.f90 dranxor.f90 -o test.x
!			
!			Next comes a description of what the generator does for you. Further details can
!			be found in 
!			
!			"Generation of Gaussian distributed random numbers by using a numerical 
!			inversion method",
!			R. Toral, A. Chakrabarti. 
!			Computer Physics Communications, 74 (1993) 327-334.
!			
!			The program is free for you to use and disseminate. However, I would appreciate
!			if proper credit were given to this reference in all those papers that
!			use the Gaussian generator.
!			
!					
!									Raul Toral
!			
!			
!			==============================================================================
!			
!			***************************************************************************
!			Disclaimer: Although we have made our best efforts to write a good code, 
!			we can not make any warranties that the programs in these routines will 
!			work in your computer. In particular, there are some bit manipulation
!			functions that might not be standard for your compiler. It is your
!			responsability to test that the random numbers generated are indeed correct.
!			****************************************************************************
!						 
!					         dranxor.f90
!			
!			******************* RANDOM NUMBER GENERATOR ***********************
!			
!			            Based on x(i)=x(i-p).xor.x(i-q) type algorithms
!			
!				Uses
!					p=1279		q=418
!				(Remember that the R250 generator uses p=250, q=103)
!			
!			Implements following functions and subroutines (DOUBLE PRECISION!!!)
!			
!			subroutine dran_ini(iseed)
!					Initializes random number generator. Must be 
!					called before any other use of the generators. 
!					
!			subroutine dran_write(iunit)
!					Writes in unit iunit the complete status of the
!					generator to continue runs.
!			
!			subroutine dran_read(iunit)
!					Reads from unit iunit the status of the 
!					generator.
!			
!			function dran_u()
!					Returns random number uniformly distributed in 
!					the interval (0,1)
!			
!			function i_dran(n)
!					Integer function. Returns an integer random 
!					number uniformly distributed in (1,n).
!			  			If n<=0 returns an integer number between 0 and 2**31-1
!			
!			function dran_g()
!					Returns Gaussian distributed (mean 0, variance 1)
!					by using a numerical inversion method.
!					It is not a real Gaussian distribution because it is cut-off
!					The cut-off value depends on the parameter np. See details in
!			
!			function dran_gbmw()
!					Returns Gaussian distributed (mean 0, variance 1)
!					by using the Box-Muller-Wiener algorithm.
!			
!			subroutine dran_uv(u,n)
!					This is the vector routine for the uniform generator:
!				        call dran_uv(x,n)
!					will fill up n-component vector x with random numbers
!					uniformly distributed in (0,1)
!			
!			subroutine ran_gv(x,n)
!					This is the vector routine for the fast Gaussian generator:
!				        call dran_gv(x,n)
!					will fill up n-component vector x with Gaussian
!					distributed (mean 0, variance 1) random numbers
!				        generated by the numerical inversion method.
!			
!			
!			
!			I will be happy to get any results from your  experience on
!			different machines. Please do spend some time checking the routines. I have 
!			done my best to ensure that there are no mistakes, but you never know. 
!			
!			
!				Finally, it might be a good idea to use a different uniform
!			random generator to check the results. It seems that other good
!			generators can be obtained based on different values:
!			
!				p=2281, q=1029
!				p=4423,	q=2098
!				p=9689, q=4187
!				etc.
!			
!			Sources are in:
!			
!				~raul/random/dranxor.f90
!			
!			
!			******************************************************************************
!			
!			Example program 1. 
!			
!			Writes in unit (6) 10 sets of (uniform,integer between 1 and 100) random numbers
!			
!				call dran_ini(87265)
!				do i=1,10
!				write(6,*) dran_u(),i_dran(100)
!				enddo
!				end
!			
!			Example program 2. 
!			
!			Computes average and variance of 100 Gaussian numbers in double
!			precision.
!			
!				implicit double precision (a-h,o-z)
!				call dran_ini(95237)
!				xm=0.0d0
!				x2=0.0d0
!				do i=1,100
!				g=dran_g()
!				xm=xm+g
!				x2=x2+g*g
!				enddo
!				xm=xm/100
!				x2=x2/100-xm*xm
!				write(6,*) xm,x2
!				end
!			
!			Example program 3. 
!			
!			Generates a vector of 100 double precision Gaussian random numbers and
!			computes its mean and variance.
!			
!				implicit double precision (a-h,o-z)
!				dimension x(100)
!				call dran_ini(365441)
!				xm=0.0d0
!				x2=0.0d0
!				call dran_gv(x,100)
!				xm=sum(x)/100
!				x2=sum(x*x)/100-xm*xm
!				write(6,*) xm,x2
!				end

subroutine dran_ini(iseed0)
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(np=14)
parameter(nbit=31)
parameter(m=2**np,np1=nbit-np,nn=2**np1-1,nn1=nn+1)
integer ix(ip)
dimension g(0:m)

data c0,c1,c2/2.515517,0.802853,0.010328/
data d1,d2,d3/1.432788,0.189269,0.001308/
data pi/3.141592653589793d0/

common /ixx/ ix
common /icc/ ic     
common /gg/ g

dseed=iseed0
do i=1,ip
 ix(i)=0
 do j=0,nbit-1
    if(rand_xx(dseed).lt.0.5) ix(i)=ibset(ix(i),j)
 enddo
enddo
ic=0

do i=m/2,m
	p=1.0-dble(i+1)/(m+2)
	t=sqrt(-2.0*log(p))
	x=t-(c0+t*(c1+c2*t))/(1.0+t*(d1+t*(d2+t*d3)))
	g(i)=x
	g(m-i)=-x
enddo

u2th=1.0-dble(m+2)/m*sqrt(2.0/pi)*g(m)*exp(-g(m)*g(m)/2)
u2th=nn1*sqrt(u2th)
g=g/u2th

return
end

subroutine dran_read(iunit)
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(np=14)
parameter(m=2**np)
integer ix(ip)
dimension g(0:m)
common /ixx/ ix
common /icc/ ic
common /gg/ g
read (iunit,*) ic
read (iunit,*) (ix(i),i=1,ip)
read (iunit,*) (g(i),i=0,m)
return
end

subroutine dran_write(iunit)
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(np=14)
parameter(m=2**np)
integer ix(ip)
dimension g(0:m)
common /ixx/ ix
common /icc/ ic      
common /gg/ g
write (iunit,*) ic
write (iunit,*) (ix(i),i=1,ip)
write (iunit,*) (g(i),i=0,m)
return
end

function i_dran(n)
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(iq=418)
parameter(is=ip-iq)
integer ix(ip)
common /ixx/ ix
common /icc/ ic
ic=ic+1
if (ic > ip) ic=1
if (ic > iq) then
ix(ic)=ieor(ix(ic),ix(ic-iq))
else
ix(ic)=ieor(ix(ic),ix(ic+is))
endif
i_dran=ix(ic)
if (n > 0) i_dran=mod(i_dran,n)+1
return
end

function dran_u()
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(iq=418)
parameter(is=ip-iq)
parameter (rmax=2147483648.0d0)
integer ix(ip)
common /ixx/ ix
common /icc/ ic
ic=ic+1
if (ic > ip) ic=1
if (ic > iq) then
ix(ic)=ieor(ix(ic),ix(ic-iq))
else
ix(ic)=ieor(ix(ic),ix(ic+is))
endif
dran_u=(dble(ix(ic))+0.5d0)/rmax
return
end


function dran_g()
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(iq=418)
parameter(np=14)
parameter(nbit=31)
parameter(m=2**np,np1=nbit-np,nn=2**np1-1,nn1=nn+1)
parameter(is=ip-iq)

integer ix(ip)
dimension g(0:m)

common /ixx/ ix
common /icc/ ic
common /gg/ g

ic=ic+1
if(ic > ip) ic=1
if(ic > iq) then
ix(ic)=ieor(ix(ic),ix(ic-iq))
else
ix(ic)=ieor(ix(ic),ix(ic+is))
endif
i=ishft(ix(ic),-np1)
i2=iand(ix(ic),nn)
dran_g=i2*g(i+1)+(nn1-i2)*g(i)
return
end


function dran_gbmw()
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(iq=418)
parameter(is=ip-iq)
parameter (rmax=2147483648.0d0)
integer ix(ip)
integer, save :: icount=1
double precision, save :: u,v
common /ixx/ ix
common /icc/ ic
data pi2 /6.283185307179586d0/
if (icount == 1) then
	ic=ic+1
	if (ic > ip) ic=1
	if (ic > iq) then
	ix(ic)=ieor(ix(ic),ix(ic-iq))
	else
	ix(ic)=ieor(ix(ic),ix(ic+is))
	endif
	u=pi2*dble(ix(ic)+0.5d0)/rmax
	ic=ic+1
	if(ic > ip) ic=1
	if(ic > iq) then
	ix(ic)=ieor(ix(ic),ix(ic-iq))
	else
	ix(ic)=ieor(ix(ic),ix(ic+is))
	endif
	v=(dble(ix(ic))+0.5d0)/rmax
	v=dsqrt(-2.0d0*log(v))
	dran_gbmw=dcos(u)*v
	icount=2
else
  dran_gbmw=dsin(u)*v
  icount=1
endif
return
end


subroutine dran_gv(u,n)
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(iq=418)
parameter(np=14)
parameter(nbit=31)
parameter(m=2**np,np1=nbit-np,nn=2**np1-1,nn1=nn+1)
parameter(is=ip-iq)
dimension g(0:m)
dimension u(n)
dimension ix(ip)
common /gg/ g
common /ixx/ ix
common /icc/ic

n1=0
do while (n1 < n)
if (ic.lt.iq) then
  kmax=min(n-n1,iq-ic)
  do k=1,kmax
    ic=ic+1
    ix(ic)=ieor(ix(ic),ix(ic+is))
    i=ishft(ix(ic),-np1)
    i2=iand(ix(ic),nn)
    u(n1+k)=i2*g(i+1)+(nn1-i2)*g(i)
  enddo
else
    kmax=min(n-n1,ip-ic)
    do k=1,kmax
      ic=ic+1
      ix(ic)=ieor(ix(ic),ix(ic-iq))
      i=ishft(ix(ic),-np1)
      i2=iand(ix(ic),nn)
      u(n1+k)=i2*g(i+1)+(nn1-i2)*g(i)
    enddo
endif
if(ic.ge.ip) ic=0
n1=n1+kmax
enddo
    
return
end

subroutine dran_uv(u,n)
implicit double precision(a-h,o-z)
parameter(ip=1279)
parameter(iq=418)
parameter(is=ip-iq)
parameter (rmax=2147483648.0d0)
dimension u(n)
dimension ix(ip)
common /ixx/ ix
common /icc/ic

n1=0
do while (n1 < n)
if (ic.lt.iq) then
  kmax=min(n-n1,iq-ic)
  do k=1,kmax
    ic=ic+1
    ix(ic)=ieor(ix(ic),ix(ic+is))
    u(n1+k)=(dble(ix(ic))+0.5d0)/rmax
  enddo
else
  kmax=min(n-n1,ip-ic)
  do k=1,kmax
    ic=ic+1
    ix(ic)=ieor(ix(ic),ix(ic-iq))
    u(n1+k)=(dble(ix(ic))+0.5d0)/rmax
  enddo
endif
if(ic.ge.ip) ic=0
n1=n1+kmax
enddo
    
return
end



function rand_xx(dseed)
double precision a,c,xm,rm,dseed,rand_xx
parameter (xm=2.d0**32,rm=1.d0/xm,a=69069.d0,c=1.d0)
dseed=mod(dseed*a+c,xm)
rand_xx=dseed*rm
return
end

