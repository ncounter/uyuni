/* eslint-disable */
import React from 'react';
import ReactDOM from 'react-dom';
import SpaRenderer from "core/spa/spa-renderer";
import SyncChannel from "./sync-channel";

export const renderer = (id, {channelId}) => SpaRenderer.renderNavigationReact(
  <SyncChannel channelId={channelId} />,
  document.getElementById(id)
);
