<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="org.hibernate.* " %>
    <%@ page import="java.util.*" %>
    <%@ page import="hibermainproject.*" %>
    <%@ page import="org.hibernate.cfg.Configuration " %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hibernate DatabaseProject</title>

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

        /* Members Section Styling */
        .members-section {
            background-color: var(--header-bg);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .members-header {
            display: flex;
            justify-content: space-between; /* This will push the heading and button to opposite ends */
            align-items: center;
            margin-bottom: 20px;
            margin-right : 20px;
        }

        .members-header .add-member-btn {
            background-color: var(--primary-purple);
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px; /* Slightly more rounded corners */
            font-size: 0.95em;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px; /* Space between icon and text */
        }

        .members-header .add-member-btn:hover {
            background-color: #5a4bbf; /* A slightly darker purple on hover */
            transform: translateY(-1px); /* Subtle lift effect */
        }

        .members-header .add-member-btn i {
            font-size: 1em; /* Adjust icon size if needed */
        }


        .members-table th {
            font-weight: 600;
            color: var(--light-text-color);
            padding-top: 15px;
            padding-bottom: 15px;
        }

        .members-table td {
            vertical-align: middle;
            padding-top: 12px;
            padding-bottom: 12px;
        }

        .members-table .operation-icons {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .members-table .operation-icons button.edit-btn {
            background: none;
            border: 1px solid #e0e0e0;
            color: var(--light-text-color);
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
            cursor: pointer;
            transition: border-color 0.2s ease, color 0.2s ease;
        }

        .members-table .operation-icons button.edit-btn:hover {
            border-color: var(--primary-purple);
            color: var(--primary-purple);
        }

        .members-table .operation-icons button.delete-btn {
            background: none;
            border: 1px solid #e0e0e0;
            color: var(--light-text-color);
            padding: 5px 8px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: border-color 0.2s ease, color 0.2s ease;
        }

        .members-table .operation-icons button.delete-btn:hover {
            border-color: var(--inactive-red);
            color: var(--inactive-red);
        }

        /* Overlay background */
        .overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
            justify-content: center;
            align-items: center;
        }

        /* Popup box */
        .popup {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .popup button {
            margin: 10px;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .popup .btn-delete-confirm { /* Renamed to avoid conflict */
            background-color: var(--primary-purple);
            color: white;
        }

        .popup .btn-cancel {
            background-color: #ccc;
        }

        /* Responsive adjustments */
        /* Medium and Small Screens (below lg breakpoint) */
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

            .members-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .members-header .add-member-btn {
                width: 100%; /* Full width on smaller screens */
                margin-top: 15px; /* Space from heading */
                justify-content: center; /* Center text and icon */
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
                <div class="members-header">
                    <div class="d-flex align-items-center">
                        <h4 class="mb-0">Members</h4>
                    </div>
                    <button class="add-member-btn" onclick="window.location.href='index.jsp'">
                        <i class="fas fa-plus"></i> Add Member
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table members-table">
                        <thead>
                            <tr>
                            	<th>ID</th>
                                <th>Member name</th>
                                <th>Mobile</th>
                                <th>Email</th>
                                <th>Operation</th>
                            </tr>
                        </thead>
                        <tbody>
 						<%
 						SessionFactory sf=new Configuration().configure().buildSessionFactory();
 						Session s=sf.openSession();
 						Query q=s.createQuery("from Blog");
 						List<Blog> l1=q.list();
 						for(Blog lst:l1)
 						{
 						%>

                            <tr>
                            	<td><%=lst.getId() %></td>
                                <td><%=lst.getName() %></td>
                                <td><%=lst.getNumber() %></td>
                                <td><%=lst.getEmail() %></td>

                                <td class="operation-icons">
                                    <%-- Modified the edit button to show the custom popup --%>
                                    <button class="edit-btn" onclick="showEditPopup(<%=lst.getId()%>)">Edit</button>
                                    
                                    <%-- Modified the delete button to show the custom popup --%>
                                    <button class="delete-btn" onclick="showDeletePopup(<%=lst.getId()%>)">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </td>
                            </tr>


                        <%
 						}
                        %>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>

    <div class="overlay" id="popupOverlay">
        <div class="popup" id="deletePopup">
            <p>Are you sure you want to delete this member?</p>
            <button class="btn-delete-confirm" id="confirmDeleteButton">Yes, Delete</button>
            <button class="btn-cancel" onclick="closePopup()">Cancel</button>
        </div>

        <div class="popup" id="editPopup" style="display: none;">
            <p>Are you sure you want to edit this member?</p>
            <button class="btn-delete-confirm" id="confirmEditButton">Yes, Edit</button>
            <button class="btn-cancel" onclick="closePopup()">Cancel</button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let memberActionId = null; // Variable to store the ID of the member for either delete or edit

        function showDeletePopup(id) {
            memberActionId = id; // Store the ID
            document.getElementById("deletePopup").style.display = "block";
            document.getElementById("editPopup").style.display = "none";
            document.getElementById("popupOverlay").style.display = "flex";
        }

        function showEditPopup(id) {
            memberActionId = id; // Store the ID
            document.getElementById("deletePopup").style.display = "none";
            document.getElementById("editPopup").style.display = "block";
            document.getElementById("popupOverlay").style.display = "flex";
        }

        function closePopup() {
            document.getElementById("popupOverlay").style.display = "none";
            document.getElementById("deletePopup").style.display = "none";
            document.getElementById("editPopup").style.display = "none";
            memberActionId = null; // Clear the ID when closing the popup
        }

        // Attach event listener to the "Yes, Delete" button inside the popup
        document.getElementById("confirmDeleteButton").addEventListener('click', function() {
            if (memberActionId !== null) {
                // Redirect to the delete servlet with the stored ID
                window.location.href = 'del?id=' + memberActionId;
            }
            closePopup(); // Close the popup after action
        });

        // Attach event listener to the "Yes, Edit" button inside the popup
        document.getElementById("confirmEditButton").addEventListener('click', function() {
            if (memberActionId !== null) {
                // Redirect to the edit servlet with the stored ID
                window.location.href = 'updateform.jsp?id=' + memberActionId;
            }
            closePopup(); // Close the popup after action
        });
    </script>
</body>
</html>