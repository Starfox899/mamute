<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="touchable" type="br.com.caelum.brutal.model.interfaces.Touchable" required="true" %>
<%@attribute name="microdata" required="false" %>
<ul class="post-touchs">
	<li class="touch author-touch">
		<tags:createdTouch touchable="${touchable}" microdata="${microdata}"/>
	</li>
	<c:if test="${touchable.edited}">
		<c:choose>
			<c:when test="${(touchable.information.author.id == touchable.author.id)}">
				<li class="touch edited-touch">
					<div class="complete-user">
						<time class="when" ${microdata ? 'itemprop="dateModified"' : ""} datetime="${touchable.information.createdAt}"><fmt:message key='touch.edited'/> <tags:prettyTime time="${touchable.information.createdAt}"/></time>
					</div>
				</li>
			</c:when>
			<c:otherwise>
				<li class="touch edited-touch" ${microdata ? 'itemscope itemtype="http://schema.org/Person" itemprop="editor"' : ""}>
					<tags:editedTouch touchable="${touchable}" microdata="${microdata}"/>
				</li>	
			</c:otherwise>
		</c:choose>
	</c:if>
</ul>