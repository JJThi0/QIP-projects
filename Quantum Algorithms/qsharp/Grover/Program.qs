namespace Grover {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation ReducedOracle1(input : Qubit) : Unit { //f2: f(x) = x i.e. object in box 1
        Z(input); //need [[1,0],[0,-1]] i.e. Z gate
    }

    
    operation GroversAlgortihm (Oracle : ((Qubit) => Unit)) : Result{
        use q = Qubit();
        H(q); //Fourier Transform q
        ReducedOracle1(q); //Apply Reduced Oracle
        X(q); //W for 1 qubit reduces to (Pauli) X
        return M(q);
    }

    @EntryPoint()
    operation main() : Result{
        return GroversAlgortihm(ReducedOracle1);
    }
}
