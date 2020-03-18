/* eslint-disable */
// @flow
import React from 'react';
import Network from "utils/network";
import {AsyncButton} from "components/buttons";
import {SectionToolbar} from "components/section-toolbar/section-toolbar";
import {showErrorToastr, showSuccessToastr} from 'components/toastr/toastr';

type SyncChannelProps = {
  channelId: number
}

type SyncChannelState = {
  channelId: number
}

class SyncChannel extends React.Component<SyncChannelProps, SyncChannelState> {
  constructor(props: SyncChannelProps) {
    super(props);
    this.state = {
      channelId: -1,
    }
  }

  syncChannel = (channelId: number) => {
    Network.get(`/rhn/manager/api/channels/sync-channel/${channelId}`)
    .promise.then(data => {
      if (!data.success) {
        showSuccessToastr("Channel sync scheduled successfully.");
      }
      else {
        showErrorToastr("Something went wrong scheduling channel sync.<br/> Please check errors on server logs.");
      }
    });
  };

  render() {
    return (
      <SectionToolbar>
        <div className='action-button-wrapper'>
          <div className='btn-group'>
            <AsyncButton
              action={() => this.syncChannel(this.props.channelId)}
              defaultType="btn-success"
              text={t("Schedule Channel Sync")} />
          </div>
        </div>
      </SectionToolbar>
    )
  }
}

export default SyncChannel;