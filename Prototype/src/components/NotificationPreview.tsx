import { Bell, X } from "lucide-react";

interface NotificationPreviewProps {
  title: string;
  body: string;
  ctaText: string;
  onCta: () => void;
  onDismiss: () => void;
  isVisible: boolean;
}

export function NotificationPreview({
  title,
  body,
  ctaText,
  onCta,
  onDismiss,
  isVisible,
}: NotificationPreviewProps) {
  if (!isVisible) return null;

  return (
    <div className="fixed top-4 right-4 z-50 max-w-sm w-full animate-in slide-in-from-top">
      <div className="bg-white rounded-2xl shadow-2xl p-5 border-l-4 border-[#1B4E9B]">
        <div className="flex items-start gap-3">
          <div className="bg-[#1B4E9B] p-2 rounded-lg">
            <Bell className="w-5 h-5 text-white" />
          </div>
          <div className="flex-1">
            <div className="flex items-start justify-between">
              <h4 className="text-[#0D1F3A]">{title}</h4>
              <button
                onClick={onDismiss}
                className="text-gray-400 hover:text-gray-600 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
            <p className="text-sm text-gray-600 mt-1">{body}</p>
            <button
              onClick={onCta}
              className="mt-3 bg-[#F0A020] hover:bg-[#d89018] text-white px-4 py-2 rounded-lg transition-colors text-sm w-full"
            >
              {ctaText}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
