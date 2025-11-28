import React from "react";


interface TopBarProps {
  activeTab: string;
  setActiveTab: (tab: string) => void;
}

// Add "ALL" at the beginning
const tabs = ["ALL", "Orders", "Quotes", "Requests", "Productions & Work Orders"];

const TopBar: React.FC<TopBarProps> = ({ activeTab, setActiveTab }) => {
  return (
    <div className="topbar">
      {tabs.map((tab) => (
        <button
  type="button"
  key={tab}
  className={`topbar-btn ${activeTab === tab ? "active" : ""}`}
  onClick={() => setActiveTab(tab)}
>
  {tab}
</button>

      ))}
    </div>
  );
};

export default TopBar;
