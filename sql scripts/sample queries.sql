1)

Select L.ApartmentID, L.RenterID, P.DatePaid, L.Rent as 'Actual Rent', P.Amount As 'Rent Paid' 
from Payment P inner join LeaseInformation L on L.RenterID = P.RenterID and L.ApartmentID = P.ApartmentID
where P.Amount < L.Rent; 

2)

Select ApartmentID, RenterID, Amount,DatePaid
from Payment P 
Order by DatePaid;

3)

Select P.ProspectNumber,P.Name,W.ApartmentID,S.Description
from Prospect P inner join WaitingList W on P.ProspectNumber = W.ProspectNumber inner join Status S on W.StatusCode = S.StatusCode
where S.Description = 'waiting';

4)

Select top 2 [ApartmentID], [RenterID], [Rent], [StartDate]
from LeaseInformation L  
order by Rent desc;


5)

Select  [ApartmentID], [RenterID], [Rent], [StartDate]
from LeaseInformation 
where StartDate = '2017-11-01' or StartDate = '2017-12-01'

6)

Select  [PaymentNumber], [DateDue], [DatePaid], [Amount], [ApartmentID], [RenterID]
from Payment
where DatePaid > DateDue;

7)

Select A.ComplexID,L.ApartmentID, L.RenterID,L.Rent,L.StartDate
from Apartment A inner join LeaseInformation L on A.ApartmentID = L.ApartmentID
order by A.ComplexID;

8)

Select C.Description, S.PersonID, S.Name
from Complex C inner join Staff S on C.PersonID = S.PersonID
where C.Description = 'Princeton'; 

9)

Select C.Description, S.PersonID, S.Name
from Complex C inner join Staff S on C.PersonID = S.PersonID
where C.Description = 'Northside'; 


10)

Select ApartmentID, NumberRents
from Apartment;

11)

Select R.RepairNum,R.Description,R.ApartmentID,T.Description,S.Name
from Repairs R inner join Type T on R.Type = T.Type
left outer join Staff S on R.PersonID = S.PersonID
where T.Description = 'Insured';
