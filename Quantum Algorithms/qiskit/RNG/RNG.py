import numpy as np
from qiskit import QuantumCircuit, transpile
from qiskit.providers.aer import QasmSimulator
from qiskit.visualization import plot_histogram

def RandomBitGenerator():
    #init simulator
    simulator = QasmSimulator()

    #create the Circuit
    circuit = QuantumCircuit(1,1)
    circuit.h(0)
    circuit.measure([0],[0])

    #Compile & Run
    compiled_circuit = transpile(circuit, simulator)
    job = simulator.run(compiled_circuit, shots=1000)
    result = job.result()

    # Returns counts
    counts = result.get_counts(compiled_circuit)


    print("\nTotal count for 0 and 1 are:",counts)
