// Copyright (c) Microsoft Corporation. All rights reserved.

namespace IPSC_Project {
    
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Convert;
    open Microsoft.Quantum.Extensions.Math;
    
    
    //////////////////////////////////////////////////////////////////
    // This is the set of programming assignments for week 3.
    //////////////////////////////////////////////////////////////////

    // The tasks cover the following topics:
    //  - Quantum Fourier Transform algorithm
    //
    
    //////////////////////////////////////////////////////////////////
    // Part I. Quantum oracles and Simon's algorithm
    //////////////////////////////////////////////////////////////////

    // In this section the oracles are defined on computational basis states,
    // as described at https://docs.microsoft.com/en-us/quantum/concepts/oracles.
    
    // Task 1.1. (Superdense Coding)
    // Inputs:
    //      1) Input: two qubits in |00⟩ state (stored in an array of length 2).
    //      
     
    operation Superdense_Coding (x : Qubit[]) : Unit 
    {

        body (...) 
		{
            let N = Length(x);
            for (i in 0 .. N - 1) 
			{

                // Step 1: Bell State Preparation

                H(x[0]);
                CNOT(x[0], x[1]);

                //Step 2. If x = 1, Alice applies the unitary transformation σz to the qubit A. (If x = 0 she does not.)

                if (M(x[0]) == One)
                {
                    Z(x[0]);
                }

                if (M(x[0]) == Zero)
                {
            
                }

                if (M(x[1]) == One)
                {
                    X(x[1]);
                }

                if (M(x[1]) == Zero)
                {
            
                }

                // Step 3. Bob applies a controlled-NOT operation to the pair (A, B), where A is the control and B is the target. 

                CNOT(x[0], x[1]);

                // Step 4. Bob applies a Hadamard transform to A. 

                H(x[0]);



            }
    
        }
		// adjoint invert;
    }

    // Task 1.1. Entangled pair

    operation Entangle_Reference (qAlice : Qubit, qBob : Qubit) : Unit {

        

        body (...) {

            H(qAlice);

            CNOT(qAlice, qBob);

        }

        

        adjoint invert;

    }

    

    

    // Task 1.2. Send the message (Alice's task)

    operation SendMessage_Reference (qAlice : Qubit, qMessage : Qubit) : (Bool, Bool) {

        CNOT(qMessage, qAlice);

        H(qMessage);

        return (M(qMessage) == One, M(qAlice) == One);

    }

    

    

    // Task 1.3. Reconstruct the message (Bob's task)

    operation ReconstructMessage_Reference (qBob : Qubit, (b1 : Bool, b2 : Bool)) : Unit {

        if (b1) {

            Z(qBob);

        }

        if (b2) {

            X(qBob);

        }

    }

    

    

    // Task 1.4. Standard teleportation protocol

    operation StandardTeleport_Reference (qAlice : Qubit, qBob : Qubit, qMessage : Qubit) : Unit {

        Entangle_Reference(qAlice, qBob);

        let classicalBits = SendMessage_Reference(qAlice, qMessage);

        

        // Alice sends the classical bits to Bob.

        // Bob uses these bits to transform his part of the entangled pair into |ψ⟩.

        ReconstructMessage_Reference(qBob, classicalBits);

    }

    

    

    // Task 1.5. Prepare the message specified and send it (Alice's task)

    operation PrepareAndSendMessage_Reference (qAlice : Qubit, basis : Pauli, state : Bool) : (Bool, Bool) {

        mutable classicalBits = (false, false);

        using (qs = Qubit[1]) {

            if (state) {

                X(qs[0]);

            }

            

            PrepareQubit(basis, qs[0]);

            set classicalBits = SendMessage_Reference(qAlice, qs[0]);

            Reset(qs[0]);

        }

        return classicalBits;

    }
    
}
