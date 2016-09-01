package org.apache.shiro.web.tags;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.tags.PermissionTag;

/**
 * 扩展标签，具有列出权限中的任意一个
 * @author yehuan
 *
 */
public class HasAnyPermissionTag extends PermissionTag {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public HasAnyPermissionTag() {

    }

    protected boolean showTagBody(String permissions) {
            boolean hasAnyPermissions = false;

            Subject subject = getSubject();

            if (subject != null) {
                    for (String role : permissions.split(",")) {

                            if (subject.isPermitted(role.trim())) {
                                    hasAnyPermissions = true;
                                    break;
                            }
                    }
            }
            return hasAnyPermissions;
    }

}
