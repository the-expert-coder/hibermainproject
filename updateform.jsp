<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Member</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --sidebar-bg: #4c3f91; /* Dark purple */
            --header-bg: #ffffff;
            --main-bg: #f5f6fa; /* Light gray for background */
            --primary-purple: #6a5acd; /* A slightly lighter purple for buttons */
            --text-color: #333;
            --light-text-color: #888;
            --active-green: #28a745;
            --inactive-red: #dc3545;
            --header-mobile-bg: #4c3f91; /* Dark purple for mobile header */
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--main-bg);
            color: var(--text-color);
        }

        /* Sidebar Styling (for Large Screens) */
        .sidebar {
            width: 250px;
            background-color: var(--sidebar-bg);
            color: #fff;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            /* Ensures it takes full height when displayed as flex column */
            min-height: 100vh;
        }

        .sidebar .logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar .logo h5 {
            margin: 0;
            font-weight: 600;
            color: #fff;
        }

        .sidebar .nav-link {
            color: #ddd;
            padding: 12px 15px;
            display: flex;
            align-items: center;
            border-radius: 5px;
            margin-bottom: 5px;
            transition: background-color 0.2s ease;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: #fff;
        }

        .sidebar .nav-link i {
            margin-right: 15px;
            font-size: 18px;
        }

        /* Offcanvas Specific Styling (for Mobile Sidebar) */
        .offcanvas {
            background-color: var(--sidebar-bg); /* Use the same dark purple background */
            color: #fff;
        }

        .offcanvas .offcanvas-header {
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .offcanvas .offcanvas-title {
            color: #fff;
            font-weight: 600;
        }

        .offcanvas .btn-close {
            filter: invert(1) grayscale(100%) brightness(200%); /* Make close button white */
        }

        .offcanvas-body .nav-link {
            color: #ddd;
            padding: 12px 15px;
            display: flex;
            align-items: center;
            border-radius: 5px;
            margin-bottom: 5px;
            transition: background-color 0.2s ease;
        }

        .offcanvas-body .nav-link:hover,
        .offcanvas-body .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: #fff;
        }

        .offcanvas-body .nav-link i {
            margin-right: 15px;
            font-size: 18px;
        }

        /* Main Content Area */
        .main-content {
            flex-grow: 1; /* Take remaining space */
            padding: 30px;
            background-color: var(--main-bg);
        }

        /* Top Header Styling */
        .header {
            background-color: var(--header-bg); /* Default white for desktop */
            padding: 15px 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .header .search-bar {
            width: 400px; /* Adjust as needed for desktop */
        }

        .header .search-bar .form-control {
            border-radius: 20px;
            padding-left: 40px; /* Space for icon */
            border: 1px solid #eee;
            background-color: #f8f9fa;
        }

        .header .search-bar .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--light-text-color);
        }

        .header .user-info {
            display: flex;
            align-items: center;
        }

        .header .user-info .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
            border: 2px solid var(--primary-purple);
        }

        .header .user-info .name {
            font-weight: 600;
            margin-bottom: 2px;
        }

        .header .user-info .role {
            font-size: 0.85em;
            color: var(--light-text-color);
        }

        /* Members Section Styling (now for the form container) */
        .members-section {
            background-color: var(--header-bg);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        /* Styles for buttons that should match sidebar color */
        .btn-primary {
            background-color: var(--sidebar-bg); /* Use sidebar-bg color */
            border-color: var(--sidebar-bg);
            color: #fff;
            transition: background-color 0.2s ease, border-color 0.2s ease;
        }

        .btn-primary:hover {
            background-color: #3b3270; /* Slightly darker shade of sidebar-bg on hover */
            border-color: #3b3270;
        }

        /* Responsive adjustments */
        @media (max-width: 991.98px) { /* Bootstrap's lg breakpoint is 992px */
            .header {
                background-color: var(--header-mobile-bg); /* Darker background for mobile header */
                color: #fff; /* White text for mobile header */
                border-radius: 0; /* No border-radius on mobile header */
                margin-bottom: 15px; /* Adjust margin */
                padding: 10px 15px; /* Adjust padding */
                display: flex;
                flex-wrap: nowrap; /* Prevent wrapping for header elements */
                justify-content: flex-start; /* Align items to start */
            }

            .header .search-bar {
                width: auto; /* Allow search bar to grow */
                flex-grow: 1; /* Search bar takes available space */
                margin-left: 15px; /* Space from title/toggler */
                margin-right: 15px;
            }

            .header .search-bar .form-control {
                background-color: rgba(255,255,255,0.1); /* Lighter background for search input */
                border-color: rgba(255,255,255,0.2); /* Lighter border for search input */
                color: #fff;
            }

            .header .search-bar .form-control::placeholder {
                color: rgba(255,255,255,0.7);
            }

            .header .search-bar .search-icon {
                color: rgba(255,255,255,0.8); /* White search icon */
            }

            .header .user-info .name,
            .header .user-info .role {
                color: #fff; /* White text for user info */
            }

            .main-content {
                padding: 15px; /* Reduce padding on main content */
            }
        }

        /* Extra Small Screens (below md breakpoint) */
        @media (max-width: 767.98px) { /* Bootstrap's md breakpoint is 768px */
            .header .user-info .name,
            .header .user-info .role {
                display: none; /* Hide name/role on very small screens for space */
            }
        }
    </style>
</head>
<body>
<%@ page import="org.hibernate.*" %> 
<%@ page import="org.hibernate.cfg.Configuration" %> 
<%@ page import="hibermainproject.*" %>
  <%
	int id=Integer.parseInt(request.getParameter("id")); 
	SessionFactory sf=new Configuration().configure().buildSessionFactory(); 
	Session s=sf.openSession(); 
	Blog bo=(Blog)s.get(Blog.class,id); 
  %>

    <div class="d-flex flex-column flex-lg-row min-vh-100">

        <div class="sidebar d-none d-lg-flex flex-column">
            <div class="logo">
                <h5>Hibernate DatabaseProject</h5>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="fas fa-user-circle"></i> <span>Profile</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-users"></i> <span>Users</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-cogs"></i> <span>Control panel</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-folder-open"></i> <span>Projects</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-tasks"></i> <span>Tasks</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-clipboard-list"></i> <span>Logs</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-comments"></i> <span>Group chats</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-chart-line"></i> <span>Reports</span></a>
                </li>
            </ul>
        </div>

        <div class="offcanvas offcanvas-start" tabindex="-1" id="sidebarOffcanvas" aria-labelledby="sidebarOffcanvasLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title text-white" id="sidebarOffcanvasLabel">Hibernate DatabaseProject</h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body d-flex flex-column">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#"><i class="fas fa-user-circle"></i> <span>Profile</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-users"></i> <span>Users</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-cogs"></i> <span>Control panel</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-folder-open"></i> <span>Projects</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-tasks"></i> <span>Tasks</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-clipboard-list"></i> <span>Logs</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-comments"></i> <span>Group chats</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-chart-line"></i> <span>Reports</span></a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main-content flex-grow-1">
            <header class="header">
                <div class="d-flex align-items-center d-lg-none">
                    <button class="btn btn-link text-white me-3 p-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas" aria-controls="sidebarOffcanvas">
                        <i class="fas fa-caret-down fa-lg"></i>
                    </button>
                    <h5 class="mb-0 text-white header-mobile-title">Hibernate DatabaseProject</h5>
                </div>

                <div class="position-relative search-bar flex-grow-1 mx-3 mx-lg-0">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="form-control" placeholder="Search...">
                </div>

                <div class="user-info d-flex align-items-center">
                    <img src="https://i.pravatar.cc/40" alt="User Avatar" class="avatar">
                    <div class="d-none d-md-block">
                        <div class="name">Luke Asote</div>
                        <div class="role">Admin for Associations</div>
                    </div>
                </div>
            </header>

            <section class="members-section">
                <div class="container mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="mb-0">Update Member Detail</h3>
                        <a href="index.html" class="btn btn-primary"><i class="fas fa-arrow-left me-2"></i> Back</a> </div>
                    <form method="post" action="upd">
                    
                    	 <div class="mb-3">
                            <label for="memberId" class="form-label">Member ID</label>
                            <input type="text" class="form-control" name="id" value="<%=bo.getId()%>" id="memberName">
                        </div>   
                        <div class="mb-3">
                            <label for="memberName" class="form-label">Member Name</label>
                            <input type="text" class="form-control" name="name" value="<%=bo.getName()%>" id="memberName">
                        </div>
                        <div class="mb-3">
                            <label for="memberPhone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" name="number" value="<%=bo.getNumber()%>" id="memberPhone">
                        </div>
                        <div class="mb-3">
                            <label for="memberEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" name="email"value="<%=bo.getEmail()%>"  id="memberEmail">
                        </div>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </div>
            </section>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>