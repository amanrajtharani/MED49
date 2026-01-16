# Team Directory Application

A full-stack employee directory application built with ColdFusion REST API and React frontend.

## 🎯 Project Overview

This application demonstrates:
- RESTful API development with ColdFusion
- Modern React with Hooks (useState, useEffect)
- Secure database operations with SQLite
- CORS handling for cross-origin requests
- Real-time search and filtering
- Responsive UI design

## 📋 Prerequisites

- **ColdFusion Server** (2016, 2018, 2021, or 2023)
- **Node.js** (v14 or higher)
- **SQLite** (or SQLite JDBC driver for ColdFusion)
- **Web Browser** (Chrome, Firefox, Safari, or Edge)

## 🚀 Quick Start

### Step 1: Database Setup

1. Navigate to the `database` folder
2. Create the SQLite database:

```bash
cd database
sqlite3 team_directory.db < setup.sql
```

Or manually execute the SQL script in your preferred SQLite tool.

3. Verify the database was created with 8 employee records

### Step 2: ColdFusion Backend Setup

1. Copy the `backend` folder to your ColdFusion web root:
   - Windows: `C:\ColdFusion2021\cfusion\wwwroot\team-directory`
   - Linux: `/opt/coldfusion2021/cfusion/wwwroot/team-directory`

2. Configure the database path in `Application.cfc`:
   - Update the `datasource` database path to match your `team_directory.db` location

3. Enable REST services in ColdFusion Administrator:
   - Navigate to: `Server Settings > REST Services`
   - Enable REST Services
   - Add REST Service Directory: `/team-directory/backend`
   - Restart ColdFusion

4. Verify REST API is working:
   ```
   http://localhost:8500/rest/employees
   ```
   You should see JSON response with employee data

### Step 3: React Frontend Setup

1. Navigate to the `frontend` folder:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Update API URL in `src/App.jsx`:
```javascript
const API_URL = 'http://localhost:8500/rest/employees';
```
(Adjust port/path based on your ColdFusion configuration)

4. Start the development server:
```bash
npm run dev
```

5. Open browser to `http://localhost:5173`

## 📁 Project Structure

```
team-directory/
├── backend/
│   ├── Application.cfc           # App config & CORS
│   ├── EmployeeService.cfc       # REST API endpoints
│   └── team_directory.db         # SQLite database
├── frontend/
│   ├── src/
│   │   ├── App.jsx               # Main React component
│   │   ├── main.jsx              # Entry point
│   │   └── index.css             # Styles
│   ├── package.json              # Dependencies
│   └── vite.config.js            # Vite configuration
├── database/
│   └── setup.sql                 # Database schema & data
└── README.md                     # This file
```

## 🔧 Configuration

### ColdFusion CORS Settings

The `Application.cfc` file includes CORS configuration for these origins:
- `http://localhost:5173` (Vite default)
- `http://localhost:3000` (Create React App)
- `http://127.0.0.1:5173`
- `http://127.0.0.1:3000`

To add additional origins, update the `allowedOrigins` array in `Application.cfc`.

### API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/rest/employees` | GET | Get all employees |
| `/rest/employees/{id}` | GET | Get employee by ID |
| `/rest/employees/search?query=term` | GET | Search employees |

## ✨ Features

### Backend (ColdFusion)
- ✅ RESTful API with proper HTTP methods
- ✅ SQL injection protection using `<cfqueryparam>`
- ✅ CORS headers for cross-origin requests
- ✅ Error handling and logging
- ✅ JSON response formatting
- ✅ SQLite database integration

### Frontend (React)
- ✅ Custom hooks (useEmployees, useDebounce)
- ✅ Real-time search with debouncing
- ✅ Department filtering
- ✅ Multi-criteria sorting
- ✅ Responsive card-based layout
- ✅ Loading states
- ✅ Error handling
- ✅ Empty state displays

## 🔒 Security Best Practices

1. **SQL Injection Prevention**: All queries use `<cfqueryparam>`
2. **CORS Whitelist**: Only specified origins are allowed
3. **Error Sanitization**: Detailed errors logged, generic messages shown to users
4. **Input Validation**: Search terms and parameters are validated
5. **No Sensitive Data Exposure**: Database credentials not exposed to frontend

## 🎨 UI Features

- **Search Bar**: Real-time filtering with 300ms debounce
- **Department Filter**: Filter by department
- **Sort Options**: By name, role, or department
- **Employee Cards**: Display name, role, email, department, hire date
- **Avatar Initials**: Auto-generated from first/last name
- **Responsive Design**: Mobile, tablet, and desktop optimized
- **Loading States**: Visual feedback during data fetch
- **Error Messages**: User-friendly error displays

## 🧪 Testing

### Test API Endpoints

1. Get all employees:
```bash
curl http://localhost:8500/rest/employees
```

2. Get specific employee:
```bash
curl http://localhost:8500/rest/employees/1
```

3. Search employees:
```bash
curl http://localhost:8500/rest/employees/search?query=Sarah
```

### Test Frontend

1. Open `http://localhost:5173` in browser
2. Try searching for employee names
3. Filter by different departments
4. Sort by different criteria
5. Check responsive behavior on mobile

## 📦 Building for Production

### Frontend Build

```bash
cd frontend
npm run build
```

This creates an optimized production build in the `dist` folder.

### Deployment

1. Copy built files from `frontend/dist` to web server
2. Update API_URL in production to your ColdFusion server
3. Configure production CORS origins in `Application.cfc`
4. Ensure ColdFusion REST services are enabled
5. Set up SSL/HTTPS for production

## 🐛 Troubleshooting

### CORS Errors
- Verify ColdFusion REST services are enabled
- Check `allowedOrigins` in `Application.cfc`
- Ensure frontend is running on allowed port

### Database Connection Issues
- Verify SQLite JDBC driver is installed
- Check database file path in `Application.cfc`
- Ensure ColdFusion has read/write permissions

### API Not Responding
- Verify REST service is registered in CF Administrator
- Check ColdFusion server logs
- Ensure correct port number (default: 8500)

### React Build Errors
- Delete `node_modules` and reinstall: `npm install`
- Clear cache: `npm cache clean --force`
- Check Node.js version: `node --version`

## 📚 Technologies Used

- **Backend**: ColdFusion (REST API)
- **Frontend**: React 18, Vite
- **Database**: SQLite
- **Styling**: Tailwind CSS
- **Icons**: Lucide React

## 👨‍💻 Development Notes

### Code Quality
- Consistent naming conventions
- Comprehensive comments
- Error boundaries
- Component separation
- Custom hooks for reusability

### Performance Optimizations
- Debounced search (300ms)
- Memoized filtering/sorting
- Lazy loading ready
- Optimized re-renders

## 📧 Contact

For questions or issues, contact the development team at MED49 Solutions Inc.

## 📄 License

This project is created as a technical assessment for MED49 Solutions Inc.

---

**Built with ❤️ for MED49 Solutions Inc.**
