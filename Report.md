# Lab 4 Assignment Report

## Student Information

Please type your name and student ID at here:

- Student Name: <your_chinese_name>
- Student ID: <your_NCKU_student_ID>

## Synthesis Questions (20 pts)

Your report should demonstrate your understanding of pipeline hazards and your specific implementation strategy. Please answer the following questions:

For **each** hazard (Forwarding case, Load-Use Stall, and Control Flush), describe:

1.  **Trigger Condition:** Under what specific circumstances does this hazard occur? (e.g., Which specific instruction sequence? Which register indices are compared?)
2.  **Resolution Strategy:** How does your hardware resolve this hazard? (e.g., Forwarding data, inserting a bubble, or flushing the pipeline?)
3.  **Implementation Logic:** How did you implement this in `Controller.v`?
    * For **Forwarding**: How do you decide priority if multiple stages have the data?
    * For **Stalls**: Which pipeline registers are held (frozen) and which are flushed?
    * For **Branches**: How do you clear the wrong-path instructions?
4. **Branch Prediction**
   - Please carefully study the branch predictor section of the handout. If it were up to you, which branch predictor design would you choose (Static vs. Dynamic, 1-bit vs. 2-bit)? Why?
   - Describe how you would design the control signals to resolve the control hazard caused by mispredictions (e.g., logic to flush instructions in IF and ID stages). *(Note: Implementation is bonus, but the conceptual description is required).*

### Your Answer

Start at here...

## Reflection Report (0 pts)

In this section, please write a short reflection about the lab:

1. What did you learn from completing this assignment?
2. What challenges did you encounter, and how did you solve them?
3. What feedback would you like to give to the TAs regarding this lab?

### You Report

Start at here...
