namespace DeutschJozsa {
    //NOTE: this is single qubit implementation. Still to generalize to multiple

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation ReducedOracle(input : Qubit[]) : Unit {
        //TODO
    }

    operation ReducedOraclef1(input : Qubit) : Unit { //f1: f(0) = f(1) = 0
        //do nothing
    }
    
    operation ReducedOraclef2(input : Qubit) : Unit { //f2: f(x) = x
        Z(input); //need [[1,0],[0,-1]] i.e. Z gate
    }

    operation ReducedOraclef3(input: Qubit) : Unit { //f3: f(0) = f(1) = 1
        //need [[-1,0],[0,-1]] i.e. id gate up to phase
    }

    operation ReducedOraclef4(input: Qubit) : Unit{ //f4: f(x)= 1 - x
        Z(input); //need [[-1,0],[0,1]] i.e. Z gate up to phase
    }

    
    operation DeutschJozsaAlgorithm(Oracle : ((Qubit) => Unit)): String{
        use q = Qubit();

        H(q); //Prepare in |+> state
        Oracle(q); //Apply the reduced oracle
        H(q); //prepare to measure in Fourier Basis

        let result = M(q); //measure the result

        if (result == One){
            return "Balanced";
        }
        else{
            return "Constant";
        }

    }

    @EntryPoint()
    operation main() : Unit{
        Message("f1 is");
        Message(DeutschJozsaAlgorithm(ReducedOraclef1));
        Message("f2 is");
        Message(DeutschJozsaAlgorithm(ReducedOraclef2));
        Message("f3 is");
        Message(DeutschJozsaAlgorithm(ReducedOraclef3));
        Message("f4 is");
        Message(DeutschJozsaAlgorithm(ReducedOraclef4));
    }


}