namespace QFT {

    //import all necessary libraries
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    
    
    /// # Summary Controlled rotation around the z axis by an angle theta
    /// 
    /// # Input
    /// ## theta: angle to be rotated by
    /// 
    /// ## control: control qubit
    /// 
    /// ## target: target qubit
    /// 
    operation CROTz(theta : Double, control : Qubit, target : Qubit) : Unit {
        Rz(theta/2.0, target);
        CNOT(control, target);
        Rz(-theta/2.0, target);
        CNOT(control, target);
        //see https://qiskit.org/textbook/ch-gates/more-circuit-identities.html#3.-Controlled-Rotations- why this scheme works
    }

    /// # Summary
    /// Quantum Fourier Transform a single qubit
    operation QFT1(register : Qubit) : Unit {
        H(register);
    }

    /// # Summary
    /// Quantum Fourier Transform 2 qubits
    operation QFT2(register : Qubit[]) : Unit{
        H(register[1]);
        CROTz(PI()/2.0, register[0], register[1]);
        H(register[0]);
    }


    /// # Summary
    /// Quantum Fourier Transform 3 qubits
    operation QFT3(register : Qubit[]) : Unit{
        H(register[2]);
        CROTz(PI()/4.0, register[0], register[2]);
        CROTz(PI()/2.0, register[1], register[2]);
        H(register[1]);
        CROTz(PI()/2.0, register[0], register[1]);
        H(register[0]);
    }

    /// # Summary 
    /// Quantum Fourier Transform a general array of Qubits. Implemented using a recursive approach.
    /// # Input
    /// ## register
    /// array of qubits
    /// ## number_of_qubits
    /// Number of qubits MINUS ONE in the register. (Sorry for the minus one, forget to count from zero)
    operation GeneralQFT(register : Qubit[], number_of_qubits : Int) : Unit {
        //number_of_qubits = number_of_qubits -1;
        if (number_of_qubits == 0){
            H(register[0]);
            return ();
        }
        else{
            H(register[number_of_qubits]);
            for index in 0 .. number_of_qubits - 1{
                CROTz(PI()/(2.0^(IntAsDouble(number_of_qubits - index))), register[index],register[number_of_qubits]);
                GeneralQFT(register, number_of_qubits-1);
            }

        }

    }

    @EntryPoint()
    operation main() : Int{
        use q = Qubit();
        QFT1(q);
        Message(BoolAsString(ResultAsBool(M(q))));

        use register = Qubit[5];
        let number_of_qubits = Length(register);
        GeneralQFT(register, number_of_qubits-1);
        return (ResultArrayAsInt(ForEach(MResetZ, register)));
        


    }
}
