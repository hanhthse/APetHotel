<ol class="breadcrumb">
    <li class="breadcrumb-item">
        <!--search-->
        <nav class="navbar navbar-light pl-sm-0">
            <form class="form-inline" action="dashboard" method="POST">
                <input type="hidden" name="action" value="searchCage"/>
                <input class="form-control mr-sm-2" 
                       type="search"
                       placeholder="Search"
                       aria-label="Search"
                       name="keyword"   
                       value="${requestScope.findKeyWord}">
                <button class="btn btn-outline-success my-2 my-sm-0 ml-sm-0" type="submit">Search Cages</button>
            </form>
        </nav>
    </li>
    <!--margin left auto-->
    <li class="breadcrumb-item ml-auto">
        <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addCagesModal">
            <!--the i tao d?u c?ng-->
            <i class="fas fa-plus" ></i> Add Cages
        </button>
    </li>

</ol>