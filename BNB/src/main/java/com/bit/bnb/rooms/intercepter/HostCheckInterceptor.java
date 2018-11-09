package com.bit.bnb.rooms.intercepter;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bit.bnb.user.model.UserVO;

public class HostCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {

		HttpSession session = request.getSession(false);
		String hostId = request.getParameter("hostId");

		if (session != null) {
			Object obj = session.getAttribute("loginUser");
			if (obj != null) {
				UserVO uv = (UserVO) session.getAttribute("loginUser");

				System.out.println(uv.getUserId());
				System.out.println(hostId);

				if (uv.getUserId().equals(hostId)) {
					return true;
				} else if (!uv.getUserId().equals(hostId)) {
					// 로그인 한 사용자가 해당 숙소의 호스트가 아닐 경우
					response.sendRedirect(request.getContextPath() + "/rooms/accessDenied");
				} else {
					response.sendRedirect(request.getContextPath() + "/login");
				}
			}

			response.sendRedirect(request.getContextPath() + "/login");
		}

		return false;
	}
}
