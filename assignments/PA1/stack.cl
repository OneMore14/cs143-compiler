(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)
 
 
 

class Stack {

    isEmpty() : Bool { true };
    
    top() : String { { abort(); ""; } };
    
    pop() : Stack { { self; } };
    
    push(s: String): Stack {
        (new RealStack).init(s, self)
    };
};

class RealStack inherits Stack {

    value: String;
    
    next: Stack;
    
    init(s: String, rest: Stack) : Stack {
      {
	 value <- s;
	 next <- rest;
	 self;
      }
   };
   
   isEmpty() : Bool { false };
   
   pop(): Stack {
       next
   };
   
   top(): String {
       value
   };
    
};


class Main inherits IO {

   myStack: Stack;
   
   main() : Object {
	{
	    
	    myStack <- new Stack;
            let running: Bool <- true  in {
            	while running loop {
            	    out_string(">");
            	    let input:String <- in_string() in {
			if isDigital(input.substr(0, 1)) then {
		            myStack <- myStack.push(input);
			} else 0 fi;
			
			if input.substr(0, 1) = "+" then {
			    myStack <- myStack.push("+");
			} else 0 fi;
			
			if input.substr(0, 1) = "s" then {
			    myStack <- myStack.push("s");
			} else 0 fi;
			
			if input.substr(0, 1) = "x" then {
			    running <- false ;
			} else 0 fi;
			
			if input.substr(0, 1) = "d" then {
			    (new DisplayCommand).op(myStack);
			} else 0 fi;
			
			if input.substr(0, 1) = "e" then {
			    let op: String in {
				if myStack.isEmpty() then {0;}
				else {
				    op <- myStack.top();
				   
				    if op = "+" then {
					myStack <- myStack.pop();
					myStack <- (new AddCommand).op(myStack);
				    } else 0 fi;
				    
				    if op = "s" then {
					myStack <- myStack.pop();
					myStack <- (new SwapCommand).op(myStack);
				    } else 0 fi;
				} fi;

			    };
			} else 0 fi;
			
            	    };
            	} pool;
            };
	}
   };
   
   isDigital(s: String): Bool {
        if s = "0" then true else
	if s = "1" then true else
	if s = "2" then true else
	if s = "3" then true else
	if s = "4" then true else
	if s = "5" then true else
	if s = "6" then true else
	if s = "7" then true else
	if s = "8" then true else
	if s = "9" then true else
	{  false; }  
        fi fi fi fi fi fi fi fi fi fi
   };

};

class StackCommand inherits IO {

    op(stack: Stack): Stack {{ abort(); stack;}};
};

class AddCommand inherits StackCommand {

    op(stack: Stack): Stack {
	{
	    let x: Int, y: Int in {
	        x <- (new A2I).c2i(stack.top());
	        stack <- stack.pop();
	        y <- (new A2I).c2i(stack.top());
	        stack <- stack.pop();
	        stack <- stack.push((new A2I).i2c(x + y));
	    };
	    stack; 
	}
    };
};


class SwapCommand inherits StackCommand {

    op(stack: Stack): Stack {
	{
	    let x: String, y: String in {
	        x <- stack.top();
	        stack <- stack.pop();
	        y <- stack.top();
	        stack <- stack.pop();
	        stack <- stack.push(x);
	        stack <- stack.push(y);
	    };
	    stack; 
	}
    };
};

class DisplayCommand inherits StackCommand {

    op(stack: Stack): Stack {
	let current: Stack <- stack in {
	    while not current.isEmpty() loop  {
	        out_string(current.top().concat("\n"));
	        current <- current.pop();
	    } pool;
	    stack;
	}
    };
};




