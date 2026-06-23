-- Scenario 1: Apply discount for customers above 60

BEGIN
   FOR c IN (
      SELECT CustomerID
      FROM Customers
      WHERE Age > 60
   )
   LOOP
      UPDATE Loans
      SET InterestRate = InterestRate - 1
      WHERE CustomerID = c.CustomerID;
   END LOOP;

   COMMIT;
END;
/

-- Scenario 2: Promote customers to VIP

BEGIN
   FOR c IN (
      SELECT CustomerID
      FROM Customers
      WHERE Balance > 10000
   )
   LOOP
      UPDATE Customers
      SET IsVIP = 'TRUE'
      WHERE CustomerID = c.CustomerID;
   END LOOP;

   COMMIT;
END;
/

-- Scenario 3: Loan reminders

BEGIN
   FOR l IN (
      SELECT c.Name,
             l.LoanID,
             l.DueDate
      FROM Customers c
      JOIN Loans l
      ON c.CustomerID = l.CustomerID
      WHERE l.DueDate BETWEEN SYSDATE AND SYSDATE + 30
   )
   LOOP
      DBMS_OUTPUT.PUT_LINE(
         'Reminder: ' || l.Name ||
         ' Loan ID: ' || l.LoanID ||
         ' Due Date: ' || l.DueDate
      );
   END LOOP;
END;
/