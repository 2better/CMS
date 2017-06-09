<#include "header.ftl">
		<div class="row">
			<div class="col-sm-8 blog-main">
				<div class="sidebar-box category-box white" style="margin-bottom: 20px;">
					<h2 class="blog-post-title">${article.title}</h2>
					<div>
						${article.content}
					</div>
				</div>
			</div>
			<!-- /.blog-sidebar -->
			<#include "sidebar.ftl">
		</div>
		<!-- /.row -->
<#include "footer.ftl">