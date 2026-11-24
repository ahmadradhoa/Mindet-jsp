package com.mindet.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AppFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session != null) {
            Object success = session.getAttribute("flash_success");
            if (success != null) {
                req.setAttribute("success", success);
                session.removeAttribute("flash_success");
            }
            Object error = session.getAttribute("flash_error");
            if (error != null) {
                req.setAttribute("error", error);
                session.removeAttribute("flash_error");
            }
            req.setAttribute("authUser", session.getAttribute("user"));
        }

        req.setAttribute("currentUri", req.getRequestURI());
        req.setAttribute("ctx", req.getContextPath());

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
