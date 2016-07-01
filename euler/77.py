import math

lookupTable = [0, 0, 1, 1, 1, 2, 2, 3] + [-1 for i in range(100000)]
lookupTable = [1, 1, 2, 3, 5, 7, 11, 15] + [-1 for i in range(100000)]

def genPrimeTable(n):
	primesTable = [2]
	k = 3
	while n > 0:
		prime = True
		for i in primesTable:
			if k % i == 0:
				prime = False
				break
		if prime:
			primesTable.append(k)
			n -= 1
		k+=2
	return primesTable

def partition(n):
	if n < 0:
		return 0
	if lookupTable[n] == -1:
		lookupTable[n] = sum([(-1)**(k+1)*(partition(n - (k*k*3+k)/2) + partition(n - (k*k*3-k)/2)) for k in range(1,n+1)]) % 1000000
	return lookupTable[n]

def primePartition(n):
	if n < 0:
		return 0
	if lookupTable[n] == -1:
		lookupTable[n] = sum([primePartition (min(n-k, k)) for k in primes[:n]])
		#lookupTable[n] = sum([primePartition (n-k) for k in primes[:n]])
	return lookupTable[n]

def altPartition(n):
	if n < 0:
		return 0
	if lookupTable[n] == -1:
		values = []
		x = 1
		p = 1
		v = x*(3*x-1)/2
		while (v <= n):
			values.append((p, v))
			values.append((p, -1*x*(-3*x-1)/2))
			x += 1
			p *= -1
			v = x*(3*x-1)/2
		lookupTable[n] = sum([(j * altPartition (n-k)) for (j, k) in values])
	return lookupTable[n]
i = 1
while 0:
	if partition(i) % 1000000 == 0:
		print i, partition(i)
		break
	i+=1

primes = genPrimeTable(1000)
print primes[:32]
i = 0
while 1:
	if partition(i) > 4999:
		print i, primePartition(i)
		break
	i+=1
#print [(j, partition(j)) for j in range(100)]
#lookupTable = [1, 1, 2, 3, 5, 7, 11, 15] + [-1 for i in range(100000)]
#print [(j, altPartition(j)) for j in range(100)]
