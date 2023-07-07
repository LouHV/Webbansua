
<style>
    /*
    DEMO STYLE
*/

@import "https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700";
body {
    font-family: 'Poppins', sans-serif;
    background: #fafafa;
}

p {
    font-family: 'Poppins', sans-serif;
    font-size: 1.1em;
    font-weight: 300;
    line-height: 1.7em;
    color: #999;
}

a,
a:hover,
a:focus {
    color: inherit;
    text-decoration: none;
    transition: all 0.3s;
}

.navbar {
    padding: 15px 10px;
    background: #fff;
    border: none;
    border-radius: 0;
    margin-bottom: 40px;
    box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
}

.navbar-btn {
    box-shadow: none;
    outline: none !important;
    border: none;
}

.line {
    width: 100%;
    height: 1px;
    border-bottom: 1px dashed #ddd;
    margin: 40px 0;
}

/* ---------------------------------------------------
    SIDEBAR STYLE
----------------------------------------------------- */

.wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
}

#sidebar {
    min-width: 250px;
    max-width: 250px;
    background: #7386D5;
    color: #fff;
    transition: all 0.3s;
}

#sidebar.active {
    margin-left: -250px;
}
.top_bar_user
{
	display: inline-block;
	margin-left: 35px;
}
.top_bar_user div
{
	display: inline-block;
}
.top_bar_user div:nth-child(2)
{
	margin-right: 21px;
}
.top_bar_user div:nth-child(2)::after
{
	display: block;
	position: absolute;
	top: 50%;
	-webkit-transform: translateY(-50%);
	-moz-transform: translateY(-50%);
	-ms-transform: translateY(-50%);
	-o-transform: translateY(-50%);
	transform: translateY(-50%);
	right: -13px;
	width: 1px;
	height: 17px;
	background: rgba(0,0,0,0.1);
	content: '';
}
.top_bar_user a
	{
		font-size: 12px;
		line-height: 40px;
	}
.top_bar_user
	{
		margin-left: 0px;
	}
.top_bar_user a
{
	font-size: 16px;
	font-weight: 300;
	line-height: 56px;
	color: #000;
	-webkit-transition: all 200ms ease;
	-moz-transition: all 200ms ease;
	-ms-transition: all 200ms ease;
	-o-transition: all 200ms ease;
	transition: all 200ms ease;
}
.top_bar_user a:hover
{
	color: #8a8a8a;
}
.top_bar_user img 
{
    width:20px;
}
#sidebar .sidebar-header {
    padding: 20px;
    background: #6d7fcc;
}

#sidebar ul.components {
    padding: 20px 0;
    border-bottom: 1px solid #47748b;
}

#sidebar ul p {
    color: #fff;
    padding: 10px;
}

#sidebar ul li a {
    padding: 10px;
    font-size: 1.1em;
    display: block;
}

#sidebar ul li a:hover {
    color: #7386D5;
    background: #fff;
}

#sidebar ul li.active>a,
a[aria-expanded="true"] {
    color: #fff;
    background: #6d7fcc;
}

a[data-toggle="collapse"] {
    position: relative;
}

.dropdown-toggle::after {
    display: block;
    position: absolute;
    top: 50%;
    right: 20px;
    transform: translateY(-50%);
}

ul ul a {
    font-size: 0.9em !important;
    padding-left: 30px !important;
    background: #6d7fcc;
}

ul.CTAs {
    padding: 20px;
}

ul.CTAs a {
    text-align: center;
    font-size: 0.9em !important;
    display: block;
    border-radius: 5px;
    margin-bottom: 5px;
}

a.download {
    background: #fff;
    color: #7386D5;
}

a.article,
a.article:hover {
    background: #6d7fcc !important;
    color: #fff !important;
}

/* ---------------------------------------------------
    CONTENT STYLE
----------------------------------------------------- */

#content {
    width: 100%;
    padding: 20px;
    min-height: 100vh;
    transition: all 0.3s;
}

/* ---------------------------------------------------
    MEDIAQUERIES
----------------------------------------------------- */

@media (max-width: 768px) {
    #sidebar {
        margin-left: -250px;
    }
    #sidebar.active {
        margin-left: 0;
    }
    #sidebarCollapse span {
        display: none;
    }
}
</style>

        <!-- Sidebar  -->
        <nav id="sidebar">
            <div class="sidebar-header">
                <h3>ADMIN</h3>
            </div>

            <ul class="list-unstyled components">
                <p>Xin Chào</p>
                <li>
                    <a href="index.asp">Trang chủ</a>
                </li>
                <li >
                    <a href="sanpham.asp">Sản Phẩm</a>
                </li>
                <li>
                    <a href="magiamgia.asp">Mã Giảm Giá</a>
                </li>
                <li>
                    <a href="hoadonnhap.asp">Hoá Đơn Nhập</a>
                </li>
                <li>
                    <a href="hoadonxuat.asp">Hoá Đơn Xuất</a>
                </li>
                <li>
                    <a href="Nhacc.asp">Nhà cung cấp</a>
                </li>
                <li>
                    <a href="danhsachmuahang.asp">Danh Sách Mua Hàng</a>
                </li>
                <li>
                    <a href="dskhachhang.asp">Thông tin khách hàng</a>
                </li>
                <li>
                    <a href="..\index.asp">Trang bán hàng</a>
                </li>
                
            </ul>
        </nav>
<script>
    $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
            });
            
        });
</script>
