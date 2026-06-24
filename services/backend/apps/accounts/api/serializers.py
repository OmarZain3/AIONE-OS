"""Auth API serializers."""

from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

User = get_user_model()


class EmailTokenObtainPairSerializer(TokenObtainPairSerializer):
    """Accept email + password for JWT issuance."""

    username_field = User.USERNAME_FIELD

    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        token["email"] = user.email
        return token


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True, trim_whitespace=False)


class RefreshTokenSerializer(serializers.Serializer):
    refresh = serializers.CharField()


class VerifyTokenSerializer(serializers.Serializer):
    token = serializers.CharField()


class LogoutSerializer(serializers.Serializer):
    refresh = serializers.CharField()


class UserSerializer(serializers.ModelSerializer):
    full_name = serializers.CharField(read_only=True)

    class Meta:
        model = User
        fields = (
            "id",
            "email",
            "first_name",
            "last_name",
            "full_name",
            "is_active",
            "date_joined",
        )
        read_only_fields = fields
