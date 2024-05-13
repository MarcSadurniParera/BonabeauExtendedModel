! Marc Sadurní Parera et al.
! Emergence of social hierarchies in a society with two competitive classes
program BonabeauExtendedModel
implicit none
!Variables/Parameters definitions
integer i,j,i_dran,L,N,N2, k, h, run, n_run, suma
parameter(N=500,N2=50) !number of NA=N and NB=N2
parameter(n_run=50) !Number of Simulations.
parameter(L=25) !system size
integer*2 S(1:L,1:L) !lattice for the agents A
integer*2 S2(1:L,1:L) !lattice for the agents B
integer*4 PBC(0:L+1) ! Boundary conditions
integer*2 pos(1:2,1:N), pos2(1:2,1:N2) !Positions in the square lattice
double precision eta, fraction, omega, omega2, omegatot !Model Parameters
double precision t1,t2,t3,tmax, t, tn, dran_u, dt, tini, tw !Times
double precision fitness(1:N), fitness2(1:N2), totalfitness !Agent fitnesses
double precision sumf, sumf_2, sumf2, sumf2_2, varsumf, varsumf2, fmax, fmax_2, f2max, f2max_2, f2maxold !Variables of averages
double precision varfmax, varf2max, corr
integer LLAV0,ILLAV,change, class !Seed and random walk moves
integer etai, etaf !Loop over eta

!Common parameters of the model
common/parameters/fraction
fraction=0.01d0

etai=0.00*100
etaf=15*100
! Seed of the random numbers
LLAV0=16645613
! Generation of the random initial configuration
ILLAV=LLAV0

!Gillespie algorithm rates
omega=dble(N)
omega2=dble(N2)
omegatot=omega+omega2

! calling a function to measure the CPU time
CALL CPU_TIME(t1)
!Opening files to store the data: Change the name depending on the number of agents in class A and B
open (30,file='50050a.dat')
open (40,file='50050b.dat')

! Periodic boundary conditions
PBC(0)=L
PBC(L+1)=1
do i=1,L
 PBC(i)=i
enddo

!Loop of eta
do k=etai,etaf,50

eta=dble(k)/100.d0
!Inicialize the same random string at each different eta simulation.
call dran_ini(ILLAV)

! Initialization of all the variables:
suma=0 !Counting variable
sumf=0.d0  !f
sumf_2=0.d0 !f^2
sumf2=0.d0 !f2
sumf2_2 =0.d0 !f2^2
varsumf=0.d0  !Var(sumf)
varsumf2=0.d0  !Var(sumf2)
fmax=0.d0 !fmax
fmax_2=0.d0 !fmax^2
f2max=0.d0 !f2max
f2max_2=0.d0 !f2max^2
varfmax=0.d0  !Var(fmax)
varf2max=0.d0  !Var(f2max)
corr=0.d0  !Correlation function for f2

!Loop runs
do run=1,n_run
! We generate the initial state in a square lattice
call matriu(L,N,N2,S,S2,pos,pos2)

! Initialize fitness of agents at t=0 - Egalitarian Solution
totalfitness=1.0d0
fitness=totalfitness/dble(N+N2)
fitness2=totalfitness/dble(N+N2)

write(*,*) "Begining of the MC loop", eta, run
! Montecarlo loop:
!time variables
tini=400000.d0   !thermalization
tmax=650000.d0 !tmax
t=0.0d0     !initialization of the time variable
tw=0.0d0   !store the data matrix only every certain time dt
dt=1000.d0    !record data every dt - 250 times

do while (t.lt.tmax) !bucle over Gillespie time
      ! Gillespie Algorithm      
      tn=-dlog(dran_u())/omegatot
      t=t+tn
      change=i_dran(4) !Random walk: Chosing randomly the move towards one of the four neighborhoods
      class=dran_u()*omegatot !Determines which class will move
  
      if (class.le.omega) then !class A moves
      i=i_dran(N) !Chose a random particle to move (In this case they are equally probable)
            if (change.eq.1) then

                  S(PBC(pos(1,i)+1),PBC(pos(2,i))) = S(PBC(pos(1,i)+1),PBC(pos(2,i)))+1
                  S(PBC(pos(1,i)),PBC(pos(2,i))) = S(PBC(pos(1,i)),PBC(pos(2,i)))-1
                  pos(1,i)=PBC(pos(1,i)+1)
                  pos(2,i)=PBC(pos(2,i))
                  
                  if (S2(pos(1,i),pos(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif

            else if (change.eq.2) then

                  S(PBC(pos(1,i)-1),PBC(pos(2,i))) = S(PBC(pos(1,i)-1),PBC(pos(2,i)))+1
                  S(PBC(pos(1,i)),PBC(pos(2,i))) = S(PBC(pos(1,i)),PBC(pos(2,i)))-1
                  pos(1,i)=PBC(pos(1,i)-1)
                  pos(2,i)=PBC(pos(2,i))
                  
                  if (S2(pos(1,i),pos(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif

            else if (change.eq.3) then

                  S(PBC(pos(1,i)),PBC(pos(2,i)+1)) = S(PBC(pos(1,i)),PBC(pos(2,i)+1))+1
                  S(PBC(pos(1,i)),PBC(pos(2,i))) = S(PBC(pos(1,i)),PBC(pos(2,i)))-1
                  pos(1,i)=PBC(pos(1,i))
                  pos(2,i)=PBC(pos(2,i)+1)

                  if (S2(pos(1,i),pos(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif

            else if (change.eq.4) then

                  S(PBC(pos(1,i)),PBC(pos(2,i)-1)) = S(PBC(pos(1,i)),PBC(pos(2,i)-1))+1
                  S(PBC(pos(1,i)),PBC(pos(2,i))) = S(PBC(pos(1,i)),PBC(pos(2,i)))-1
                  pos(1,i)=PBC(pos(1,i))
                  pos(2,i)=PBC(pos(2,i)-1)

                  if (S2(pos(1,i),pos(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif
            endif
      else ! Class B moves
      i=i_dran(N2) !Chose a random particle to move (In this case they are equally probable)
            if (change.eq.1) then

                  S2(PBC(pos2(1,i)+1),PBC(pos2(2,i))) = S2(PBC(pos2(1,i)+1),PBC(pos2(2,i)))+1
                  S2(PBC(pos2(1,i)),PBC(pos2(2,i))) = S2(PBC(pos2(1,i)),PBC(pos2(2,i)))-1
                  pos2(1,i)=PBC(pos2(1,i)+1)
                  pos2(2,i)=PBC(pos2(2,i))
                  
                  if (S(pos2(1,i),pos2(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight2(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif

            else if (change.eq.2) then

                  S2(PBC(pos2(1,i)-1),PBC(pos2(2,i))) = S2(PBC(pos2(1,i)-1),PBC(pos2(2,i)))+1
                  S2(PBC(pos2(1,i)),PBC(pos2(2,i))) = S2(PBC(pos2(1,i)),PBC(pos2(2,i)))-1
                  pos2(1,i)=PBC(pos2(1,i)-1)
                  pos2(2,i)=PBC(pos2(2,i))
                  
                  if (S(pos2(1,i),pos2(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight2(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif

            else if (change.eq.3) then

                  S2(PBC(pos2(1,i)),PBC(pos2(2,i)+1)) = S2(PBC(pos2(1,i)),PBC(pos2(2,i)+1))+1
                  S2(PBC(pos2(1,i)),PBC(pos2(2,i))) = S2(PBC(pos2(1,i)),PBC(pos2(2,i)))-1
                  pos2(1,i)=PBC(pos2(1,i))
                  pos2(2,i)=PBC(pos2(2,i)+1)

                  if (S(pos2(1,i),pos2(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight2(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif

            else if (change.eq.4) then

                  S2(PBC(pos2(1,i)),PBC(pos2(2,i)-1)) = S2(PBC(pos2(1,i)),PBC(pos2(2,i)-1))+1
                  S2(PBC(pos2(1,i)),PBC(pos2(2,i))) = S2(PBC(pos2(1,i)),PBC(pos2(2,i)))-1
                  pos2(1,i)=PBC(pos2(1,i))
                  pos2(2,i)=PBC(pos2(2,i)-1)

                  if (S(pos2(1,i),pos2(2,i)).ge.1) then
                        ! Do a simple random fight agent i vs agent j
                        call fight2(eta,i,N,N2,pos,pos2,fitness,fitness2)
                  endif
            endif
      ENDIF

! Write after the first steps (thermalization) and every dt:
! writing data every dt seconds
      if ((t.ge.tini).and.((t-tw).gt.dt)) then
            suma=suma+1 !Counting variable
            sumf=sumf+sum(fitness)  !f
            sumf_2=sumf_2+sum(fitness)**2 !f^2
            sumf2=sumf2+sum(fitness2) !f2
            sumf2_2 =sumf2_2+sum(fitness2)**2 !f2^2
            fmax=fmax+MAXVAL(fitness) !fmax
            fmax_2=fmax_2+MAXVAL(fitness)**2 !fmax^2
            f2max=f2max+MAXVAL(fitness2) !f2max
            f2max_2=f2max_2+MAXVAL(fitness2)**2 !f2max^2
            corr=corr+MAXVAL(fitness2)*f2maxold  !Correlation function
            f2maxold=MAXVAL(fitness2)
            tw=t
      endif

! End loop of MC
enddo

CALL CPU_TIME(t3)
write(*,*) "CPU TIME", t3-t1

write(*,*) run, sumf/dble(suma), sumf2/dble(suma), sumf/dble(suma) + sumf2/dble(suma)

enddo ! End loop Runs

sumf=sumf/dble(suma)
sumf_2=sumf_2/dble(suma)
sumf2=sumf2/dble(suma)
sumf2_2=sumf2_2/dble(suma)
fmax=fmax/dble(suma)
fmax_2=fmax_2/dble(suma)
f2max=f2max/dble(suma)
f2max_2=f2max_2/dble(suma)
varsumf=sumf_2-sumf*sumf
varsumf2=sumf2_2-sumf2*sumf2
varfmax=fmax_2-fmax*fmax
varf2max=f2max_2-f2max*f2max
corr=(corr/dble(suma)-f2max*f2max)/varf2max

write(30,*) N, sumf+sumf2, eta, suma, sumf, sumf_2, varsumf, fmax, fmax_2, varfmax
write(40,*) N2, sumf+sumf2, eta, suma, sumf2, sumf2_2, varsumf2, f2max, f2max_2, varf2max, corr
!Enddo loop Eta/Temperatures
CALL CPU_TIME(t2)
write(*,*) "Finish eta:", eta, "Partial CPU TIME", t2-t1
enddo

CALL CPU_TIME(t3)
write(*,*) "Total CPU TIME", t3-t1

close(30)
close(40)
end program

! Subroutine that generate a random spin matrix:
! INPUTS: long, agents,agents2
! OUTPUTS: spins,spins2,pos,pos2
subroutine matriu(long,agents,agents2,spins,spins2,pos,pos2)                                
implicit none
integer long,i,j,agents,agents2,u,v,k,k2
integer*2 spins(1:long,1:long), spins2(1:long,1:long), pos(1:2,1:agents), pos2(1:2,1:agents2), i_dran

!Initialize both lattices with zeros
do i=1,long
      do j=1,long
            spins(i,j)=0
            spins2(i,j)=0
      enddo
enddo
!Colocate agents A in the lattice (randomly and there can be more than 1 agent in each site)
k=agents
do while (k.ne.0)
      u=i_dran(long)
      v=i_dran(long)

      spins(u,v) = spins(u,v)+1
      pos(1,k)=u
      pos(2,k)=v

      k=k-1

enddo
!Colocate agents B in the lattice (randomly and there can be more than 1 agent in each site)
k2=agents2
do while (k2.ne.0)
      u=i_dran(long)
      v=i_dran(long)

      spins2(u,v) = spins2(u,v)+1
      pos2(1,k2)=u
      pos2(2,k2)=v

      k2=k2-1

enddo
write(*,*) "Inizialization finished", long
end subroutine

!Subroutine fight (if class A moves)
!INPUTS: i, N, N2, pos, pos2, fitness, fitness2
!OUTPUTS: fitness, fitness2
subroutine fight(eta,i,N,N2,pos,pos2,fitness,fitness2)
implicit none
integer i_dran,N,N2,k
integer*2 pos(1:2,1:N), pos2(1:2,1:N2)
integer*4 agents2(1:N2), contador, i, particle
double precision fitness(1:N), fitness2(1:N2), winner1, f1, f2, probability, dran_u
double precision eta, fraction
double precision fitnessmax, fitnessmin, fitness2max, fitness2min, fitnessnorm, fitness2norm
external probability
common/parameters/fraction

! Do a simple random fight
agents2=0
contador=0
particle=0
do k=1,N2
      if((pos2(1,k).eq.pos(1,i)).and.(pos2(2,k).eq.pos(2,i))) then
            contador=contador+1
            agents2(contador)=k
      endif
enddo
particle=agents2(i_dran(contador)) !Choosing a random particle between the possible ones.

f1=fitness(i) !Fitness of the agent A
f2=fitness2(particle) !Fitness of the agent B

!Reescale both fitness between 0 and 1 to compare them.
fitnessmax=MAXVAL(fitness)
fitnessmin=MINVAL(fitness)
fitness2max=MAXVAL(fitness2)
fitness2min=MINVAL(fitness2)

if (fitnessmax.ne.fitnessmin) then
      fitnessnorm=(f1-fitnessmin)/(fitnessmax-fitnessmin)
else
      fitnessnorm=1.d0
endif

if (fitness2max.ne.fitness2min) then
      fitness2norm=(f2-fitness2min)/(fitness2max-fitness2min)
else
      fitness2norm=1.d0
endif
! Computing the probability that the agent A wins agent B.
winner1=probability(eta,fitnessnorm,fitness2norm)
!Perform the exchange
if(dran_u().lt.winner1) then
      fitness(i)=fitness(i)+fraction*f2
      fitness2(particle)=fitness2(particle)*(1.d0-fraction)
else
      fitness(i)=fitness(i)*(1.d0-fraction)
      fitness2(particle)=fitness2(particle)+fraction*f1
endif

end subroutine

!Subroutine fight 2 (if class B moves)
!INPUTS: i, N, N2, pos, pos2, fitness, fitness2
!OUTPUTS: fitness, fitness2
subroutine fight2(eta,i,N,N2,pos,pos2,fitness,fitness2)
implicit none
integer i_dran,N,N2,k
integer*2 pos(1:2,1:N), pos2(1:2,1:N2)
integer*4 agent(1:N), contador, i, particle
double precision fitness(1:N), fitness2(1:N2), winner1, f1, f2, probability, dran_u
double precision eta, fraction
double precision fitnessmax, fitnessmin, fitness2max, fitness2min, fitnessnorm, fitness2norm
external probability
common/parameters/fraction

! Do a simple random fight
agent=0
contador=0
particle=0
do k=1,N
      if((pos(1,k).eq.pos2(1,i)).and.(pos(2,k).eq.pos2(2,i))) then
            contador=contador+1
            agent(contador)=k
      endif
enddo
particle=agent(i_dran(contador)) !Choosing a random particle between the possible ones.

f1=fitness(particle) !Fitness of the agent A
f2=fitness2(i) !Fitness of the agent B

!Reescale both fitness between 0 and 1 to compare them.
fitnessmax=MAXVAL(fitness)
fitnessmin=MINVAL(fitness)
fitness2max=MAXVAL(fitness2)
fitness2min=MINVAL(fitness2)

if (fitnessmax.ne.fitnessmin) then
      fitnessnorm=(f1-fitnessmin)/(fitnessmax-fitnessmin)
else
      fitnessnorm=1.d0
endif

if (fitness2max.ne.fitness2min) then
      fitness2norm=(f2-fitness2min)/(fitness2max-fitness2min)
else
      fitness2norm=1.d0
endif

! Computing the probability that the agent A wins agent B.
winner1=probability(eta,fitnessnorm,fitness2norm)

if(dran_u().lt.winner1) then
      fitness(particle)=fitness(particle)+fraction*f2
      fitness2(i)=fitness2(i)*(1.d0-fraction)
else
      fitness(particle)=fitness(particle)*(1.d0-fraction)
      fitness2(i)=fitness2(i)+fraction*f1
endif

end subroutine

! Function Probability to win
!INPUTS: eta, F1, F2
!OUTPUTS: probability
double precision function probability(eta,F1,F2)
implicit none
double precision F1, F2, eta

probability = 1.0d0/(1.d0+dexp(eta*(F2-F1)))

RETURN 
end