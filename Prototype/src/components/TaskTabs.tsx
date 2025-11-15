interface TaskTabsProps {
  activeTab: "todo" | "done";
  onTabChange: (tab: "todo" | "done") => void;
  todoCount?: number;
  doneCount?: number;
}

export function TaskTabs({ activeTab, onTabChange, todoCount, doneCount }: TaskTabsProps) {
  return (
    <div className="bg-white rounded-2xl p-2 flex gap-2 shadow-sm">
      <button
        onClick={() => onTabChange("todo")}
        className={`flex-1 py-3 px-6 rounded-xl transition-all ${
          activeTab === "todo"
            ? "bg-[#1B4E9B] text-white shadow-md"
            : "text-[#0D1F3A] hover:bg-[#F2F2F2]"
        }`}
      >
        Do zrobienia
        {todoCount !== undefined && (
          <span className={`ml-2 ${activeTab === "todo" ? "opacity-80" : "opacity-60"}`}>
            ({todoCount})
          </span>
        )}
      </button>
      <button
        onClick={() => onTabChange("done")}
        className={`flex-1 py-3 px-6 rounded-xl transition-all ${
          activeTab === "done"
            ? "bg-[#1B4E9B] text-white shadow-md"
            : "text-[#0D1F3A] hover:bg-[#F2F2F2]"
        }`}
      >
        Zrobione
        {doneCount !== undefined && (
          <span className={`ml-2 ${activeTab === "done" ? "opacity-80" : "opacity-60"}`}>
            ({doneCount})
          </span>
        )}
      </button>
    </div>
  );
}
