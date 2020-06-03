/* eslint-disable */
// @flow
'use strict';

const React = require("react");
const ReactDOM = require("react-dom");

const {DateTimePicker} = require("./datetimepicker");
const {Combobox} = require("./combobox");
import type {ComboboxItem} from "./combobox";
const Functions = require("../utils/functions");
const Network = require("utils/network");
const {Loading} = require("components/utils/Loading");

export type MaintenanceWindow = {
  id: number,
  from: string,
  to: string,
}

export type ActionChain = {
  id: number,
  text: string
};

type ActionScheduleProps = {
  earliest: Date,
  timezone: string,
  localTime: string,
  actionChains: Array<ActionChain>,
  onDateTimeChanged: (date: Date) => void,
  onActionChainChanged: (actionChain: ?ActionChain) => void,
  systemIds: Array<number>
};

type ActionScheduleState = {
  loading: boolean,
  type: "earliest" | "actionChain",
  earliest: Date,
  actionChain: ActionChain,
  actionChains: Array<ActionChain>,
  isMaintenanceModeEnabled: boolean,
  maintenanceWindow: MaintenanceWindow,
  maintenanceWindows: Array<MaintenanceWindow>
};

var MWs = [
  {
    id: new Date("2020-06-11T10:00:00Z").getTime(),
    from: Functions.Formats.LocalDateTime(new Date("2020-06-11T10:00:00Z")),
    to: Functions.Formats.LocalDateTime(new Date("2020-06-11T20:00:00Z"))
  },
  {
    id: new Date("2020-10-23T02:00:00Z").getTime(),
    from: Functions.Formats.LocalDateTime(new Date("2020-10-23T02:00:00Z")),
    to: Functions.Formats.LocalDateTime(new Date("2020-10-23T14:00:00Z"))
  }
];

class ActionSchedule extends React.Component<ActionScheduleProps, ActionScheduleState> {

  newActionChainOpt = {id: Number(0), text: t("new action chain")};

  constructor(props: ActionScheduleProps) {
    super(props);

    this.state = {
      loading: true,
      type: "earliest",
      earliest: props.earliest,
      actionChain: props.actionChains.length > 0 ? props.actionChains[0] : this.newActionChainOpt,
      actionChains: props.actionChains.length > 0 ? props.actionChains : [this.newActionChainOpt],
      isMaintenanceModeEnabled: MWs.length > 0,
      maintenanceWindow: MWs[0],
      maintenanceWindows: MWs,
    };
  }

  componentWillMount = () => {
    const systemIds = this.props.systemIds;
    Network.get("/rhn/manager/api/maintenance-windows", systemIds, "application/json").promise
      .then(data =>
        {
          this.setState({
            loading: false,
            maintenanceWindow: data.maintenanceWindows
          });
        }
      ).catch(this.handleResponseError);
  }

  handleResponseError = (jqXHR) => {
    console.log(Network.responseErrorMessage(jqXHR));
    this.setState({ loading: false });
  }

  onDateTimeChanged = (date: Date) => {
    this.setState({
      type: "earliest",
      earliest: date
    });
    this.props.onDateTimeChanged(date);
  }

  onSelectEarliest = () => {
    this.onDateTimeChanged(this.state.earliest);
  }

  onMaintenanceWindowChanged = (selectedItem: MaintenanceWindow) => {
    this.onDateTimeChanged(Functions.Utils.dateWithTimezone(selectedItem.from));
  }

  onSelectMaintenanceWindow = (event: Object) => {
    this.onMaintenanceWindowChanged(MWs.filter(mw => mw.id == event.target.value)[0]);
  }

  onFocusMaintenanceWindow = (event: Object) => {
    this.onMaintenanceWindowChanged(MWs.filter(mw => mw.id == event.target.value)[0]);
  }

  onActionChainChanged = (selectedItem: ActionChain) => {
    let newActionChain: ActionChain;

    if (!selectedItem.id) {
      // new option let's generate a new id
      newActionChain = {
        id: Number(-1),
        text: selectedItem.text
      }
    } else {
      newActionChain = {
        id: selectedItem.id,
        text: selectedItem.text
      }
    }

    this.props.onActionChainChanged(newActionChain);
    this.setState({
      type: "actionChain",
      actionChain: newActionChain,
    });
  }

  onSelectActionChain = (selectedItem: ComboboxItem) => {
    this.onActionChainChanged({
      id: selectedItem.id,
      text: selectedItem.text
    });
  }

  onFocusActionChain = () => {
    this.onActionChainChanged(this.state.actionChain);
  }

  render() {
    if (this.state.loading) {
      return <Loading text={t('Loading the scheduler...')}/>
    }

    return (
      <div className="spacewalk-scheduler">
        <div className="form-horizontal">
          <div className="form-group">
            <div className="col-sm-3 control-label">
              <input type="radio" name="use_date" value="true" checked={this.state.type == "earliest"} id="schedule-by-date" onChange={this.onSelectEarliest} />
              <label htmlFor="schedule-by-date">{!this.state.isMaintenanceModeEnabled ?t("Earliest:") : t("Maintenance Window:")}</label>
            </div>
            <div className="col-sm-3">
              <select
                  id="maintenance-window"
                  className="form-control"
                  name="maintenance_window"
                  onChange={this.onSelectMaintenanceWindow}
                  onFocus={this.onFocusMaintenanceWindow}>
                { this.state.maintenanceWindows.map(mw =><option key={mw.id} value={mw.id}> {mw.from + " - " + mw.to}</option>) }
              </select>
            </div>
            <div className="col-sm-6">
              {
                !this.state.isMaintenanceModeEnabled ?
                  <DateTimePicker onChange={this.onDateTimeChanged} value={this.state.earliest} timezone={this.props.timezone} />
                  : null
              }
            </div>
          </div>
          <div className="form-group">
            <div className="col-sm-3 control-label">
              <input type="radio" name="action_chain" value="false" checked={this.state.type == "actionChain"} id="schedule-by-action-chain" onChange={this.onFocusActionChain}/>
              <label htmlFor="schedule-by-action-chain">{t("Add to:")}</label>
            </div>
            <div className="col-sm-3">
              <Combobox id="action-chain" name="action_chain" selectedId={this.state.actionChain.id}
                        data={this.state.actionChains} onSelect={this.onSelectActionChain}
                        onFocus={this.onFocusActionChain} />
            </div>
          </div>
        </div>
      </div>
    );
  }

}

module.exports = {
  ActionSchedule: ActionSchedule
}
