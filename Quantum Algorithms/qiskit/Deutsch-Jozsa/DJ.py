import numpy as np
from qiskit import QuantumCircuit, transpile
from qiskit.providers.aer import QasmSimulator

def Oracle(input_size, case = 'constant'):

    Oracle_Circuit = QuantumCircuit(input_size+1)

    if(case == 'constant'): #f(x) = 1 for all x
        Oracle_Circuit.x(input_size)

    if(case == 'balanced'): #all even number of 1s give zero, one else
        for i in range(input_size):
            Oracle_Circuit.cx(i,input_size)

    return Oracle_Circuit

def DeutschJozsa(oracle, n):
    qc = QuantumCircuit(n+1, n)
    # init output qubit to |->:
    qc.x(n)
    qc.h(n)

    # Transform to Fourier Basis (kinda):
    for i in range(n):
        qc.h(i)

    # Apply the oracle:
    qc.append(oracle, range(n+1))

    # Transform back to z basis
    for i in range(n):
        qc.h(i)

    #
    for i in range(n):
        qc.measure(i, i)

    return qc

if __name__ == '__main__':
    # init simulator
    simulator = QasmSimulator()

    #apply the algorithm
    qc = DeutschJozsa(Oracle(6, case = 'balanced'),6)

    #Compile & Run
    compiled_circuit = transpile(qc, simulator)
    job = simulator.run(compiled_circuit, shots=1000)
    result = job.result()

    # Returns counts
    counts = result.get_counts(compiled_circuit)

    print(counts)
