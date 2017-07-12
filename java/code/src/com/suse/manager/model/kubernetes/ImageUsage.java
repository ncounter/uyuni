/**
 * Copyright (c) 2017 SUSE LLC
 * <p>
 * This software is licensed to you under the GNU General Public License,
 * version 2 (GPLv2). There is NO WARRANTY for this software, express or
 * implied, including the implied warranties of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
 * along with this software; if not, see
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
 * <p>
 * Red Hat trademarks are not licensed under GPLv2. No permission is
 * granted to use or replicate Red Hat trademarks that are incorporated
 * in this software or its documentation.
 */

package com.suse.manager.model.kubernetes;

import com.redhat.rhn.domain.image.ImageInfo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by matei on 7/11/17.
 */
public class ImageUsage {

    private ImageInfo imageInfo;
    private List<ContainerInfo> containerInfos = new ArrayList<>();

    public ImageUsage(ImageInfo imageInfo) {
        this.imageInfo = imageInfo;
    }

    public ImageInfo getImageInfo() {
        return imageInfo;
    }

    /**
     * @param imageInfoIn to set
     */
    public void setImageInfo(ImageInfo imageInfoIn) {
        this.imageInfo = imageInfoIn;
    }

    public List<ContainerInfo> getContainerInfos() {
        return containerInfos;
    }

    /**
     * @param containersIn to set
     */
    public void setContainerInfos(List<ContainerInfo> containersIn) {
        this.containerInfos = containersIn;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ImageUsage)) return false;

        ImageUsage that = (ImageUsage) o;

        return imageInfo.equals(that.imageInfo);
    }

    @Override
    public int hashCode() {
        return imageInfo.hashCode();
    }
}
