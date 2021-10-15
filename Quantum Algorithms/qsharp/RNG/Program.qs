namespace Qrng {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    //@EntryPoint()
    operation GenerateRandomBit() : Result {
        use q = Qubit();   // Allocate a qubit.
        H(q);              // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
        return MResetZ(q); // Measure the qubit value.
    }

    
    operation GenerateRandomArray(number_of_bits: Int) : Result[] {
        use register = Qubit[number_of_bits]; //init an arraay of qubits
        ApplyToEach(H,register); //put all qubits in |+>
        return ForEach(MResetZ, register); // measure & return
    }

    @EntryPoint()
    operation GenerateRandomNumber(max_number: Int) : Int {
        mutable answer = max_number+1; //this will ultimately store the answer. For now, we'll give it an invalid value
        repeat{
            let word_length = Floor(Lg(IntAsDouble(max_number))) + 1; //number of bits necessary to rep. max number
            let register = GenerateRandomArray(word_length); //use earlier defined functiom
            set answer = ResultArrayAsInt(register); //convert an array of (result) bits to a base ten value
        }
        until answer < max_number; //if an invalid number is given, retry

        return answer;
    }
}
