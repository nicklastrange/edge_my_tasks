import { CheckSquare, AlertTriangle, TrendingUp, Users } from "lucide-react";
import { MetricCard } from "../components/MetricCard";

export function AdminDashboard() {
  return (
    <div className="p-8">
      <div className="mb-8">
        <h1 className="text-[#0D1F3A] mb-2">Dashboard</h1>
        <p className="text-gray-600">Przegląd aktywności i statystyk zadań</p>
      </div>

      {/* Metrics Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <MetricCard
          title="Aktywne zadania"
          value={124}
          subtitle="W tym tygodniu"
          color="blue"
          icon={<CheckSquare className="w-8 h-8" />}
        />
        <MetricCard
          title="Zaległe zadania"
          value={15}
          subtitle="Wymagają uwagi"
          color="orange"
          icon={<AlertTriangle className="w-8 h-8" />}
        />
        <MetricCard
          title="Wskaźnik ukończenia"
          value="87%"
          subtitle="+5% w tym miesiącu"
          color="blue"
          icon={<TrendingUp className="w-8 h-8" />}
        />
        <MetricCard
          title="Aktywni użytkownicy"
          value={156}
          subtitle="Z 180 pracowników"
          color="blue"
          icon={<Users className="w-8 h-8" />}
        />
      </div>

      {/* Recent Events */}
      <div className="bg-white rounded-2xl p-6 shadow-sm mb-6">
        <h3 className="text-[#0D1F3A] mb-6">Ostatnio utworzone wydarzenia</h3>
        
        <div className="space-y-4">
          {[
            {
              title: "Szkolenie BHP Q4",
              category: "Obowiązkowe",
              groups: ["Wszyscy pracownicy"],
              deadline: "15 wrz 2024",
              tasksGenerated: 180,
              status: "active",
            },
            {
              title: "Rozliczenie kart paliwowych",
              category: "Finanse",
              groups: ["Dział sprzedaży"],
              deadline: "10 wrz 2024",
              tasksGenerated: 24,
              status: "active",
            },
            {
              title: "Ankieta satysfakcji",
              category: "HR",
              groups: ["Marketing", "Dział IT"],
              deadline: "20 wrz 2024",
              tasksGenerated: 45,
              status: "draft",
            },
          ].map((event, idx) => (
            <div
              key={idx}
              className="flex flex-col lg:flex-row lg:items-center justify-between p-4 border border-gray-200 rounded-xl hover:border-[#1B4E9B] transition-colors gap-4"
            >
              <div className="flex-1">
                <div className="flex items-center gap-3 mb-2">
                  <p className="text-[#0D1F3A]">{event.title}</p>
                  <span className="px-2 py-1 bg-[#F0A020]/20 text-[#F0A020] rounded-lg text-xs">
                    {event.category}
                  </span>
                </div>
                <div className="flex flex-wrap gap-2 mb-2">
                  {event.groups.map((group) => (
                    <span
                      key={group}
                      className="px-2 py-1 bg-[#1B4E9B]/10 text-[#1B4E9B] rounded-lg text-xs"
                    >
                      {group}
                    </span>
                  ))}
                </div>
                <p className="text-xs text-gray-500">
                  {event.tasksGenerated} zadań wygenerowanych
                </p>
              </div>
              <div className="flex items-center gap-4">
                <span className="text-sm text-gray-600 whitespace-nowrap">do {event.deadline}</span>
                <span
                  className={`px-3 py-1 rounded-full text-sm whitespace-nowrap ${
                    event.status === "active"
                      ? "bg-green-100 text-green-700"
                      : "bg-gray-100 text-gray-700"
                  }`}
                >
                  {event.status === "active" ? "Aktywne" : "Szkic"}
                </span>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Quick Actions */}
      <div className="bg-white rounded-2xl p-6 shadow-sm">
        <h3 className="text-[#0D1F3A] mb-6">Szybkie akcje</h3>
        
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          <button className="bg-[#1B4E9B] hover:bg-[#163d7a] text-white p-4 rounded-xl transition-colors text-left">
            <CheckSquare className="w-6 h-6 mb-2" />
            <p>Utwórz nowe wydarzenie</p>
          </button>
          <button className="bg-[#F0A020] hover:bg-[#d89018] text-white p-4 rounded-xl transition-colors text-left">
            <Users className="w-6 h-6 mb-2" />
            <p>Zarządzaj pracownikami</p>
          </button>
          <button className="border-2 border-[#1B4E9B] text-[#1B4E9B] hover:bg-[#1B4E9B] hover:text-white p-4 rounded-xl transition-colors text-left">
            <TrendingUp className="w-6 h-6 mb-2" />
            <p>Zobacz raporty</p>
          </button>
        </div>
      </div>
    </div>
  );
}