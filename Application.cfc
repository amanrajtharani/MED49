component {
    // Application settings
    this.name = "TeamDirectoryApp";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
    this.setClientCookies = true;
    
    // Database configuration (SQLite)
    this.datasource = {
        database: expandPath("./team_directory.db"),
        driver: "other",
        class: "org.sqlite.JDBC",
        connectionString: "jdbc:sqlite:" & expandPath("./team_directory.db")
    };
    
    // Application startup
    function onApplicationStart() {
        application.initialized = true;
        return true;
    }
    
    // Request initialization
    function onRequestStart(targetPage) {
        // Enable CORS for React frontend
        var origin = "";
        
        // Get the origin from the request headers
        if (structKeyExists(getHttpRequestData().headers, "Origin")) {
            origin = getHttpRequestData().headers.Origin;
        }
        
        // Whitelist of allowed origins (adjust for production)
        var allowedOrigins = [
            "http://localhost:5173",  // Vite default
            "http://localhost:3000",  // Create React App default
            "http://127.0.0.1:5173",
            "http://127.0.0.1:3000"
        ];
        
        // Set CORS headers if origin is allowed
        if (arrayContains(allowedOrigins, origin)) {
            var headers = getPageContext().getResponse();
            headers.setHeader("Access-Control-Allow-Origin", origin);
            headers.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            headers.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, X-Requested-With");
            headers.setHeader("Access-Control-Allow-Credentials", "true");
            headers.setHeader("Access-Control-Max-Age", "3600");
        }
        
        // Handle preflight OPTIONS requests
        if (cgi.request_method == "OPTIONS") {
            abort;
        }
        
        return true;
    }
    
    // Error handling
    function onError(exception, eventName) {
        var errorResponse = {
            "success": false,
            "error": "An error occurred processing your request",
            "timestamp": now()
        };
        
        // Log the actual error (don't expose to client)
        writeLog(
            text = "Error in #eventName#: #exception.message#",
            type = "error",
            file = "team_directory"
        );
        
        // Return sanitized error to client
        cfheader(name="Content-Type", value="application/json");
        writeOutput(serializeJSON(errorResponse));
        abort;
    }
}
