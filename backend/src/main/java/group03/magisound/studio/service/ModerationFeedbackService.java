package group03.magisound.studio.service;

import group03.magisound.studio.dto.response.RejectionDetailsResponse;
import group03.magisound.studio.dto.response.RejectionFeedbackResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service tra cứu phản hồi từ chối kiểm duyệt (UC-15 - View Rejection Reason).
 */
@Service
@RequiredArgsConstructor
public class ModerationFeedbackService {

    private final StudioTrackService studioTrackService;

    @Transactional(readOnly = true)
    public RejectionFeedbackResponse getRejectionFeedback(Long trackId, String currentUserEmail) {
        RejectionDetailsResponse details = studioTrackService.getRejectionDetails(trackId, currentUserEmail);
        return RejectionFeedbackResponse.fromDetails(details);
    }
}
