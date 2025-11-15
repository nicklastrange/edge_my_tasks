import { PieChart, Pie, Cell, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from "recharts";

export function StatisticsPage() {
  const completionData = [
    { name: "Ukończone", value: 87, color: "#1B4E9B" },
    { name: "Nieukończone", value: 13, color: "#F0A020" },
  ];

  const tasksData = [
    { name: "Pon", completed: 12, overdue: 2 },
    { name: "Wt", completed: 15, overdue: 1 },
    { name: "Śr", completed: 18, overdue: 3 },
    { name: "Czw", completed: 14, overdue: 1 },
    { name: "Pt", completed: 20, overdue: 4 },
    { name: "Sob", completed: 8, overdue: 0 },
    { name: "Ndz", completed: 5, overdue: 0 },
  ];

  const reminderEffectivenessData = [
    { name: "24h przed", effectiveness: 85 },
    { name: "3h przed", effectiveness: 92 },
    { name: "1h przed", effectiveness: 78 },
  ];

  return (
    <div className="p-8">
      <div className="mb-8">
        <h1 className="text-[#0D1F3A] mb-2">Statystyki</h1>
        <p className="text-gray-600">Analiza wydajności i skuteczności zadań</p>
      </div>

      <div className="space-y-6">
        {/* Completion Rate */}
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <h3 className="text-[#0D1F3A] mb-6">Wskaźnik ukończenia zadań</h3>
          <div className="flex flex-col lg:flex-row items-center gap-8">
            <div className="w-full lg:w-1/2">
              <ResponsiveContainer width="100%" height={300}>
                <PieChart>
                  <Pie
                    data={completionData}
                    cx="50%"
                    cy="50%"
                    innerRadius={80}
                    outerRadius={120}
                    paddingAngle={5}
                    dataKey="value"
                  >
                    {completionData.map((entry, index) => (
                      <Cell key={`cell-${index}`} fill={entry.color} />
                    ))}
                  </Pie>
                  <Tooltip />
                </PieChart>
              </ResponsiveContainer>
            </div>
            <div className="w-full lg:w-1/2 space-y-4">
              {completionData.map((item) => (
                <div key={item.name} className="flex items-center justify-between p-4 bg-[#F2F2F2] rounded-xl">
                  <div className="flex items-center gap-3">
                    <div
                      className="w-4 h-4 rounded-full"
                      style={{ backgroundColor: item.color }}
                    />
                    <span className="text-[#0D1F3A]">{item.name}</span>
                  </div>
                  <span className="text-[#0D1F3A]">{item.value}%</span>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Tasks Completed vs Overdue */}
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <h3 className="text-[#0D1F3A] mb-6">Zadania wykonane vs zaległe (ostatni tydzień)</h3>
          <ResponsiveContainer width="100%" height={350}>
            <BarChart data={tasksData}>
              <CartesianGrid strokeDasharray="3 3" stroke="#E5E7EB" />
              <XAxis dataKey="name" stroke="#6B7280" />
              <YAxis stroke="#6B7280" />
              <Tooltip
                contentStyle={{
                  backgroundColor: "#FFFFFF",
                  border: "none",
                  borderRadius: "12px",
                  boxShadow: "0 4px 6px -1px rgb(0 0 0 / 0.1)",
                }}
              />
              <Legend />
              <Bar dataKey="completed" fill="#1B4E9B" name="Ukończone" radius={[8, 8, 0, 0]} />
              <Bar dataKey="overdue" fill="#F0A020" name="Zaległe" radius={[8, 8, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        </div>

        {/* Reminder Effectiveness */}
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <h3 className="text-[#0D1F3A] mb-6">Skuteczność przypomnień</h3>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={reminderEffectivenessData} layout="vertical">
              <CartesianGrid strokeDasharray="3 3" stroke="#E5E7EB" />
              <XAxis type="number" stroke="#6B7280" />
              <YAxis type="category" dataKey="name" stroke="#6B7280" />
              <Tooltip
                contentStyle={{
                  backgroundColor: "#FFFFFF",
                  border: "none",
                  borderRadius: "12px",
                  boxShadow: "0 4px 6px -1px rgb(0 0 0 / 0.1)",
                }}
              />
              <Bar dataKey="effectiveness" fill="#1B4E9B" name="Skuteczność (%)" radius={[0, 8, 8, 0]} />
            </BarChart>
          </ResponsiveContainer>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-gradient-to-br from-[#1B4E9B] to-[#163d7a] text-white rounded-2xl p-6 shadow-lg">
            <p className="text-sm opacity-90 mb-2">Średni czas wykonania</p>
            <h2 className="text-white mb-1">2.4 dni</h2>
            <p className="text-sm opacity-80">-0.3 dni vs poprzedni miesiąc</p>
          </div>
          
          <div className="bg-gradient-to-br from-[#F0A020] to-[#d89018] text-white rounded-2xl p-6 shadow-lg">
            <p className="text-sm opacity-90 mb-2">Najpopularniejsza kategoria</p>
            <h2 className="text-white mb-1">HR</h2>
            <p className="text-sm opacity-80">42% wszystkich zadań</p>
          </div>
          
          <div className="bg-gradient-to-br from-[#0D1F3A] to-[#1B4E9B] text-white rounded-2xl p-6 shadow-lg">
            <p className="text-sm opacity-90 mb-2">Aktywność użytkowników</p>
            <h2 className="text-white mb-1">94%</h2>
            <p className="text-sm opacity-80">+7% vs poprzedni miesiąc</p>
          </div>
        </div>
      </div>
    </div>
  );
}
