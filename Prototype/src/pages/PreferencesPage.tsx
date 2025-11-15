import { useState } from "react";
import { ArrowLeft, MessageSquare, Mail, Smartphone, MessageCircle, Check } from "lucide-react";

export function PreferencesPage({ onBack }: { onBack: () => void }) {
  const [channels, setChannels] = useState({
    teams: true,
    whatsapp: true,
    sms: false,
    email: true,
  });

  const [reminder, setReminder] = useState<"24h" | "3h" | "1h">("3h");

  const toggleChannel = (channel: keyof typeof channels) => {
    setChannels((prev) => ({ ...prev, [channel]: !prev[channel] }));
  };

  return (
    <div className="min-h-screen bg-[#F2F2F2]">
      {/* Top Bar */}
      <div className="bg-white shadow-sm sticky top-0 z-10">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center gap-4">
            <button
              onClick={onBack}
              className="p-2 hover:bg-[#F2F2F2] rounded-lg transition-colors"
            >
              <ArrowLeft className="w-6 h-6 text-[#0D1F3A]" />
            </button>
            <h1 className="text-[#0D1F3A]">Ustawienia powiadomień</h1>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="space-y-6">
          {/* Notification Channels */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <h3 className="text-[#0D1F3A] mb-6">Kanały powiadomień</h3>
            
            <div className="space-y-4">
              {/* Teams */}
              <div className="flex items-center justify-between p-4 hover:bg-[#F2F2F2] rounded-xl transition-colors">
                <div className="flex items-center gap-4">
                  <div className="bg-[#1B4E9B]/10 p-3 rounded-lg">
                    <MessageSquare className="w-6 h-6 text-[#1B4E9B]" />
                  </div>
                  <div>
                    <p className="text-[#0D1F3A]">Microsoft Teams</p>
                    <p className="text-sm text-gray-500">Powiadomienia przez Teams</p>
                  </div>
                </div>
                <button
                  onClick={() => toggleChannel("teams")}
                  className={`relative w-14 h-8 rounded-full transition-colors ${
                    channels.teams ? "bg-[#1B4E9B]" : "bg-gray-300"
                  }`}
                >
                  <div
                    className={`absolute top-1 w-6 h-6 bg-white rounded-full transition-transform ${
                      channels.teams ? "translate-x-7" : "translate-x-1"
                    }`}
                  />
                </button>
              </div>

              {/* WhatsApp */}
              <div className="flex items-center justify-between p-4 hover:bg-[#F2F2F2] rounded-xl transition-colors">
                <div className="flex items-center gap-4">
                  <div className="bg-green-100 p-3 rounded-lg">
                    <MessageCircle className="w-6 h-6 text-green-600" />
                  </div>
                  <div>
                    <p className="text-[#0D1F3A]">WhatsApp</p>
                    <p className="text-sm text-gray-500">Wiadomości na WhatsApp</p>
                  </div>
                </div>
                <button
                  onClick={() => toggleChannel("whatsapp")}
                  className={`relative w-14 h-8 rounded-full transition-colors ${
                    channels.whatsapp ? "bg-[#1B4E9B]" : "bg-gray-300"
                  }`}
                >
                  <div
                    className={`absolute top-1 w-6 h-6 bg-white rounded-full transition-transform ${
                      channels.whatsapp ? "translate-x-7" : "translate-x-1"
                    }`}
                  />
                </button>
              </div>

              {/* SMS */}
              <div className="flex items-center justify-between p-4 hover:bg-[#F2F2F2] rounded-xl transition-colors">
                <div className="flex items-center gap-4">
                  <div className="bg-purple-100 p-3 rounded-lg">
                    <Smartphone className="w-6 h-6 text-purple-600" />
                  </div>
                  <div>
                    <p className="text-[#0D1F3A]">SMS</p>
                    <p className="text-sm text-gray-500">Wiadomości tekstowe</p>
                  </div>
                </div>
                <button
                  onClick={() => toggleChannel("sms")}
                  className={`relative w-14 h-8 rounded-full transition-colors ${
                    channels.sms ? "bg-[#1B4E9B]" : "bg-gray-300"
                  }`}
                >
                  <div
                    className={`absolute top-1 w-6 h-6 bg-white rounded-full transition-transform ${
                      channels.sms ? "translate-x-7" : "translate-x-1"
                    }`}
                  />
                </button>
              </div>

              {/* Email */}
              <div className="flex items-center justify-between p-4 hover:bg-[#F2F2F2] rounded-xl transition-colors">
                <div className="flex items-center gap-4">
                  <div className="bg-[#F0A020]/10 p-3 rounded-lg">
                    <Mail className="w-6 h-6 text-[#F0A020]" />
                  </div>
                  <div>
                    <p className="text-[#0D1F3A]">Email</p>
                    <p className="text-sm text-gray-500">Powiadomienia e-mail</p>
                  </div>
                </div>
                <button
                  onClick={() => toggleChannel("email")}
                  className={`relative w-14 h-8 rounded-full transition-colors ${
                    channels.email ? "bg-[#1B4E9B]" : "bg-gray-300"
                  }`}
                >
                  <div
                    className={`absolute top-1 w-6 h-6 bg-white rounded-full transition-transform ${
                      channels.email ? "translate-x-7" : "translate-x-1"
                    }`}
                  />
                </button>
              </div>
            </div>
          </div>

          {/* Reminder Timing */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <h3 className="text-[#0D1F3A] mb-6">Przypomnienia</h3>
            
            <div className="space-y-3">
              {[
                { value: "24h", label: "24 godziny przed terminem" },
                { value: "3h", label: "3 godziny przed terminem" },
                { value: "1h", label: "1 godzinę przed terminem" },
              ].map((option) => (
                <button
                  key={option.value}
                  onClick={() => setReminder(option.value as typeof reminder)}
                  className={`w-full flex items-center justify-between p-4 rounded-xl transition-all ${
                    reminder === option.value
                      ? "bg-[#1B4E9B]/10 border-2 border-[#1B4E9B]"
                      : "border-2 border-gray-200 hover:border-[#1B4E9B]/50"
                  }`}
                >
                  <span className="text-[#0D1F3A]">{option.label}</span>
                  {reminder === option.value && (
                    <div className="bg-[#F0A020] rounded-full p-1">
                      <Check className="w-4 h-4 text-white" />
                    </div>
                  )}
                </button>
              ))}
            </div>
          </div>

          {/* Save Button */}
          <button className="w-full bg-[#1B4E9B] hover:bg-[#163d7a] text-white py-4 rounded-xl transition-colors shadow-lg">
            Zapisz ustawienia
          </button>
        </div>
      </div>
    </div>
  );
}
