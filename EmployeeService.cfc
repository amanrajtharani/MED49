/**
 * Employee Service Component
 * RESTful API for Team Directory
 * Provides CRUD operations for employee data
 */
component displayname="EmployeeService" restpath="employees" rest="true" {
    
    /**
     * Get all employees
     * @httpMethod GET
     * @restPath ""
     * @produces application/json
     */
    remote function getEmployees() 
        httpmethod="GET" 
        restpath="" 
        produces="application/json" {
        
        var result = {
            "success": false,
            "data": [],
            "message": "",
            "timestamp": now()
        };
        
        try {
            // Query with cfqueryparam for SQL injection protection
            var qEmployees = queryExecute("
                SELECT 
                    ID,
                    FirstName,
                    LastName,
                    Role,
                    Email,
                    Department,
                    HireDate
                FROM Employees
                ORDER BY LastName, FirstName
            ", {}, {
                datasource: application.datasource
            });
            
            // Convert query to array of structs
            var employees = [];
            for (var row in qEmployees) {
                arrayAppend(employees, {
                    "id": row.ID,
                    "firstName": row.FirstName,
                    "lastName": row.LastName,
                    "role": row.Role,
                    "email": row.Email ?: "",
                    "department": row.Department ?: "",
                    "hireDate": row.HireDate ?: ""
                });
            }
            
            result.success = true;
            result.data = employees;
            result.message = "Successfully retrieved #arrayLen(employees)# employees";
            
        } catch (any e) {
            result.success = false;
            result.message = "Error retrieving employees";
            
            // Log detailed error (not exposed to client)
            writeLog(
                text = "getEmployees Error: #e.message# - #e.detail#",
                type = "error",
                file = "employee_service"
            );
        }
        
        // Set response headers
        restSetResponse({
            status: 200,
            content: result
        });
        
        return result;
    }
    
    /**
     * Get employee by ID
     * @httpMethod GET
     * @restPath "/{id}"
     * @produces application/json
     */
    remote function getEmployee(required numeric id) 
        httpmethod="GET" 
        restpath="/{id}" 
        produces="application/json" {
        
        var result = {
            "success": false,
            "data": {},
            "message": "",
            "timestamp": now()
        };
        
        try {
            // Use cfqueryparam for SQL injection protection
            var qEmployee = queryExecute("
                SELECT 
                    ID,
                    FirstName,
                    LastName,
                    Role,
                    Email,
                    Department,
                    HireDate
                FROM Employees
                WHERE ID = :id
            ", {
                id: {value: arguments.id, cfsqltype: "cf_sql_integer"}
            }, {
                datasource: application.datasource
            });
            
            if (qEmployee.recordCount > 0) {
                result.success = true;
                result.data = {
                    "id": qEmployee.ID,
                    "firstName": qEmployee.FirstName,
                    "lastName": qEmployee.LastName,
                    "role": qEmployee.Role,
                    "email": qEmployee.Email ?: "",
                    "department": qEmployee.Department ?: "",
                    "hireDate": qEmployee.HireDate ?: ""
                };
                result.message = "Employee found";
            } else {
                result.message = "Employee not found";
                restSetResponse({status: 404});
            }
            
        } catch (any e) {
            result.success = false;
            result.message = "Error retrieving employee";
            
            writeLog(
                text = "getEmployee Error: #e.message#",
                type = "error",
                file = "employee_service"
            );
        }
        
        return result;
    }
    
    /**
     * Search employees by name or role
     * @httpMethod GET
     * @restPath "/search"
     * @produces application/json
     */
    remote function searchEmployees(string query = "") 
        httpmethod="GET" 
        restpath="/search" 
        produces="application/json" {
        
        var result = {
            "success": false,
            "data": [],
            "message": "",
            "timestamp": now()
        };
        
        try {
            var searchTerm = "%" & arguments.query & "%";
            
            var qSearch = queryExecute("
                SELECT 
                    ID,
                    FirstName,
                    LastName,
                    Role,
                    Email,
                    Department,
                    HireDate
                FROM Employees
                WHERE 
                    FirstName LIKE :searchTerm
                    OR LastName LIKE :searchTerm
                    OR Role LIKE :searchTerm
                    OR Department LIKE :searchTerm
                ORDER BY LastName, FirstName
            ", {
                searchTerm: {value: searchTerm, cfsqltype: "cf_sql_varchar"}
            }, {
                datasource: application.datasource
            });
            
            var employees = [];
            for (var row in qSearch) {
                arrayAppend(employees, {
                    "id": row.ID,
                    "firstName": row.FirstName,
                    "lastName": row.LastName,
                    "role": row.Role,
                    "email": row.Email ?: "",
                    "department": row.Department ?: "",
                    "hireDate": row.HireDate ?: ""
                });
            }
            
            result.success = true;
            result.data = employees;
            result.message = "Found #arrayLen(employees)# matching employees";
            
        } catch (any e) {
            result.success = false;
            result.message = "Error searching employees";
            
            writeLog(
                text = "searchEmployees Error: #e.message#",
                type = "error",
                file = "employee_service"
            );
        }
        
        return result;
    }
}
