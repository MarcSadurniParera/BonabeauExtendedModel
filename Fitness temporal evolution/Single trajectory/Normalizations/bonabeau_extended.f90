! Marc Sadurní Parera et al.
! Emergence of social hierarchies in a society with two competitive classes
program BonabeauExtendedModel
implicit none
!Variables/Parameters definitions
integer i,j,h,i_dran,L,N,N2,longvec !Model Parameters
parameter(N=500,N2=50) !number of NA=N and NB=N2
integer*2, ALLOCATABLE :: S(:,:) !lattice for the agents A
integer*2, ALLOCATABLE :: S2(:,:) !lattice for the agents B
integer*4, ALLOCATABLE :: PBC(:) ! Boundary conditions
integer*2 pos(1:2,1:N), pos2(1:2,1:N2) !Positions in the square lattice
double precision eta, fraction, omega, omega2, omegatot !Model Parameters
double precision t1,t2,t3,tmax, t, tn, dran_u !Times
double precision fitness(1:N), fitness2(1:N2), totalfitness !Agent fitnesses
integer LLAV0,ILLAV,change, movements, class !Seed and random walk moves

!Common parameters of the model
common/parameters/fraction
fraction=0.01d0

longvec=25
eta=5.0d0
! Seed of the random numbers
LLAV0=16645613
! Generation of the random initial configuration
ILLAV=LLAV0

!Gillespie algorithm rates
omega=dble(N)
omega2=dble(N2)
omegatot=omega+omega2

! Calling a function to measure the CPU time
CALL CPU_TIME(t1)
!Opening file to store the data - Commend one or another depending on the Normalization in the Subroutines fights
open (40,file='fitness2Range.dat')
!open (40,file='fitness2Mean.dat')

!Inicialize the random string
call dran_ini(ILLAV)

!Chose the system size and create the matrices
L=longvec
ALLOCATE(S(1:L,1:L))
ALLOCATE(S2(1:L,1:L))
ALLOCATE(PBC(0:L+1))

! Periodic boundary conditions
PBC(0)=L
PBC(L+1)=1
do i=1,L
 PBC(i)=i
enddo

! Initialize fitness of agents at t=0 - Egalitarian Solution
totalfitness=1000.d0
fitness=totalfitness/dble(N+N2)
fitness2=totalfitness/dble(N+N2)

! We generate the initial state in a square lattice
call matriu(L,N,N2,S,S2,pos,pos2)

write(*,*) "Begining of the MC loop", L
!Montecarlo loop:
!Time variables
tmax=15000.d0 !tmax
t=0.0d0     !initialization of the time variable
movements=0   !Store data every some movements

!Store the observables in a file
write(40,*) t, (fitness2(j), j=1,N2)
do while (t.lt.tmax) !bucle over Gillespie time
      ! Gillespie Algorithm    
      tn=-dlog(dran_u())/omegatot
      t=t+tn
      movements=movements+1
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
      !Store the data every some movements
      if (mod(movements,15000).eq.0) then
            write(40,*) t, (fitness2(j), j=1,N2)
      endif

! End loop of MC
enddo

CALL CPU_TIME(t2)
write(*,*) "Finish density:", L, dble(N)/dble(L*L),  "Partial CPU TIME", t2-t1, sum(fitness)+sum(fitness2)
DEALLOCATE (S)
DEALLOCATE (S2)
DEALLOCATE(PBC)

CALL CPU_TIME(t3)
write(*,*) "Total CPU TIME", t3-t1

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
double precision fitnessmax, fitnessmin, fitness2max, fitness2min, fitnessnorm, fitness2norm, avfitness, avfitness2
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
avfitness=sum(fitness)/N
avfitness2=sum(fitness2)/N2

! COMMEND AND DESCOMMEND depending on the normalization case of study
if (fitnessmax.ne.fitnessmin) then
      !fitnessnorm=(f1-fitnessmin)/(fitnessmax-fitnessmin)
      fitnessnorm=-1.d0+((f1-fitnessmin)*2.d0)/(fitnessmax-fitnessmin)
      !fitnessnorm=(f1-avfitness)/(fitnessmax-fitnessmin)
else
      fitnessnorm=1.d0
endif

if (fitness2max.ne.fitness2min) then
      !fitness2norm=(f2-fitness2min)/(fitness2max-fitness2min)
      fitness2norm=-1.d0+((f2-fitness2min)*2.d0)/(fitness2max-fitness2min)
      !fitness2norm=(f2-avfitness2)/(fitness2max-fitness2min)
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
double precision fitnessmax, fitnessmin, fitness2max, fitness2min, fitnessnorm, fitness2norm, avfitness, avfitness2
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
avfitness=sum(fitness)/N
avfitness2=sum(fitness2)/N2

! COMMEND AND DESCOMMEND depending on the normalization case of study
if (fitnessmax.ne.fitnessmin) then
      !fitnessnorm=(f1-fitnessmin)/(fitnessmax-fitnessmin)
      fitnessnorm=-1.d0+((f1-fitnessmin)*2.d0)/(fitnessmax-fitnessmin)
      !fitnessnorm=(f1-avfitness)/(fitnessmax-fitnessmin)
else
      fitnessnorm=1.d0
endif

if (fitness2max.ne.fitness2min) then
      !fitness2norm=(f2-fitness2min)/(fitness2max-fitness2min)
      fitness2norm=-1.d0+((f2-fitness2min)*2.d0)/(fitness2max-fitness2min)
      !fitness2norm=(f2-avfitness2)/(fitness2max-fitness2min)
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