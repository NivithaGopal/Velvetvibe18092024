<%@ page import="dao.FavoriteDAO, bean.ServiceVelvetvibeBean, dao.ServiceVelvetvibeDAO, dao.UserRegistrationDAO, bean.UserRegistration, java.util.*" %>
<%
    HttpSession httpsession = request.getSession(false);
    String email = null;

    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserRegistrationDAO userDAO = new UserRegistrationDAO();
    UserRegistration user = userDAO.getUserByEmail(email);

    if (user == null) {
        response.sendRedirect("login.jsp?message=User not found");
        return;
    }

    int userId = user.getUser_id();

    // Fetch favorite items for the user
    FavoriteDAO favoriteDAO = new FavoriteDAO();
    List<Integer> favoriteServiceIds = favoriteDAO.getFavoriteServiceIds(userId);

    if (favoriteServiceIds != null && !favoriteServiceIds.isEmpty()) {
        ServiceVelvetvibeDAO velvetvibeDAO = new ServiceVelvetvibeDAO();
        List<ServiceVelvetvibeBean> favoriteServices = velvetvibeDAO.getServicesByIds(favoriteServiceIds);

        if (favoriteServices != null && !favoriteServices.isEmpty()) {
%>
            <h3>Your Favorite Services</h3>
            <div class="container">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Amount From</th>
                            <th>Amount To</th>
                            <th>Images</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (ServiceVelvetvibeBean service : favoriteServices) {
                                // Truncate description to a maximum of 100 characters
                                String description = service.getDescription();
                                String truncatedDescription = description.length() > 100 ? description.substring(0, 200) + "..." : description;
                        %>
                        <tr>
                            <td><%= service.getCategoryName() %></td>
                            <td title="<%= description %>" class="text-truncate" style="max-width: 200px;"><%= truncatedDescription %></td>
                            <td>&#x20B9 <%= service.getAmount_from() %></td>
                            <td>&#x20B9 <%= service.getAmount_to() %></td>
                            <td>
                                <div class="row">
                                    <div class="col-md-4">
                                        <img src="<%= service.getImage1() %>" class="img-thumbnail" alt="Service Image 1" style="width: 100px;">
                                    </div>
                                    <div class="col-md-4">
                                        <img src="<%= service.getImage2() %>" class="img-thumbnail" alt="Service Image 2" style="width: 100px;">
                                    </div>
                                    <div class="col-md-4">
                                        <img src="<%= service.getImage3() %>" class="img-thumbnail" alt="Service Image 3" style="width: 100px;">
                                    </div>
                                </div>
                            </td>
                            <td>
                                <button class="btn btn-success" id="bookNowButton<%= service.getServicevv_id() %>">Book Now</button>
                            </td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
        <%
        } else {
        %>
            <div class="alert alert-warning" role="alert">No favorite services found.</div>
        <%
        }
    } else {
    %>
        <div class="alert alert-warning" role="alert">No favorite services found.</div>
    <%
    }
%>
