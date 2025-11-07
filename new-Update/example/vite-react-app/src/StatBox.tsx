import React from "react";
import "./App.css";

interface StatBoxProps {
  title: string;
  values: { label: string; value: number }[];
}

const StatBox: React.FC<StatBoxProps> = ({ title, values }) => {
  return (
    <div className="stat-box">
      <h2 className="stat-title">{title}</h2>
      <div className="stat-inner">
        <div className="stat-column">
          <p className="stat-label">{values[0].label}</p>
          <p className="stat-value">{values[0].value}</p>
        </div>
        <div className="vertical-divider"></div>
        <div className="stat-column">
          <p className="stat-label">{values[1].label}</p>
          <p className="stat-value">{values[1].value}</p>
        </div>
      </div>
    </div>
  );
};

export default StatBox;
